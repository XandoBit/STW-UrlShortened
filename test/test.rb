# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Tests de la pagina raiz ('/') con metodo get" do

    it "Carga de la web desde el servidor" do
        get '/'
        assert last_response.ok?
    end
    it "Existe un formulario para las Urls" do
	get '/auth/:name/callback'
	assert last_response.body.include?
    end

    it "El titulo deberia de ser" do
        get '/'
        assert_match "<title>Acortador de URLS</title>", last_response.body
    end
end

