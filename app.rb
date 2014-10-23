#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'omniauth-oauth2'
require 'omniauth-google-oauth2'
require 'haml'
require 'uri'
require 'pp'
#require 'socket'
require 'data_mapper'

DataMapper.setup( :default, ENV['DATABASE_URL'] || 
                            "sqlite3://#{Dir.pwd}/my_shortened_urls.db" )
DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

Base = 36
$email=""

use OmniAuth::Builder do
  config = YAML.load_file 'config/config.yml'
  provider :google_oauth2, config['identifier'], config['secret']
end

enable :sessions
set :session_secret, '*&(^#234a)'

get '/' do
  haml :oauth
  #redirect '/index'
end

get '/auth/:name/callback' do
  @auth = request.env['omniauth.auth']
#  pp @auth
  $email = @auth['info'].email
  puts "inside get '/': #{params}"
  @list = ShortenedUrl.all(:order => [ :id.asc ], :limit => 20, :email=>$email)
  # in SQL => SELECT * FROM "ShortenedUrl" ORDER BY "id" ASC
  haml :index
end

get '/edit/:id' do |id|
  @content = ShortenedUrl.get!(id) #.first(:id => params[:id].to_i(Base))
  #erb :'show'
  erb :'edit'
end

put '/edit/url/:id' do |id|
  content = ShortenedUrl.get!(id)
  success = content.update!(params[:content])
  
  if success
    redirect "/auth/:name/callback"# "/articles/#{id}"
  else
    #redirect "/articles/#{id}/edit"
  end
end

post '/auth/:name/callback' do
  puts "inside post '/': #{params}"
  uri = URI::parse(params[:url])
  if uri.is_a? URI::HTTP or uri.is_a? URI::HTTPS then
    begin
      #@short_url = ShortenedUrl.first_or_create(:url => params[:url], :opc_url => params[:opc_url])
      if params[:opc_url] == ""
        @short_url = ShortenedUrl.first_or_create(:url => params[:url], :opc_url => params[:opc_url], :email => $email)
      else
        @short_opc_url = ShortenedUrl.first_or_create(:url => params[:url],  :opc_url => params[:opc_url], :email => $email)
      end
#     @short_url = ShortenedUrl.first_or_create(:url => params[:url], :email => $email)
     rescue Exception => e
      puts "EXCEPTION!!!!!!!!!!!!!!!!!!!"
      pp @short_url
      puts e.message
    end
  else
    logger.info "Error! <#{params[:url]}> is not a valid URL"
  end
  redirect '/auth/:name/callback'
end

delete '/:id' do |id|
  content = ShortenedUrl.get!(id)
  content.destroy!
  redirect "/auth/:name/callback"
end

get '/:shortened' do
  puts "inside get '/:shortened': #{params}"
  short_url = ShortenedUrl.first(:id => params[:shortened].to_i(Base))
  short_opc_url = ShortenedUrl.first(:opc_url => params[:shortened])
if short_opc_url #Si tiene información, entonces devolvera por opc_ulr
    redirect short_opc_url.url, 301
  else
  # HTTP status codes that start with 3 (such as 301, 302) tell the
  # browser to go look for that resource in another location. This is
  # used in the case where a web page has moved to another location or
  # is no longer at the original location. The two most commonly used
  # redirection status codes are 301 Move Permanently and 302 Found.
  redirect short_url.url, 301
end
end

get '/auth/failure' do
  redirect '/'
end

get '/logout' do
  session.clear
  redirect 'https://accounts.google.com/Logout' + to('/')
end

error do haml :index end
