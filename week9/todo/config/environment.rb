#environment.rb
require 'bundler/setup'

APP_ENV = ENV["RACK_ENV"] || "development"

Bundler.require :default, APP_ENV.to_sym


require 'rubygems'
require 'bundler'

require_rel '../app'


def logged_in?
  !!current_user
end

def current_user
  @current_user ||= User.find(session['user_id']) if session['user_id']
end
