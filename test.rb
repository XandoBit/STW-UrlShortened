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

