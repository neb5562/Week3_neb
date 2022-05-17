#config.ru

require_relative './config/environment'
require 'sinatra/activerecord'

DB_ENV ||= 'development'
connection_details = YAML::load(File.open('config/database.yml'), aliases: true)
ActiveRecord::Base.establish_connection(connection_details[DB_ENV])
ActiveRecord::Base.connection

if ActiveRecord::Base.connected? 
  puts "CONNECTED!" 
else
  puts "NOT CONNECTED!"
end

run ApplicationController
use Rack::MethodOverride
use UsersController
use AuthController
use TodoController

