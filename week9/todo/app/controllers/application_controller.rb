require "./config/environment"
require 'date'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
    register Sinatra::Flash
  end

  get "/" do
    @list ||= logged_in? ? current_user.todos.all().order(Arel.sql("(deadline - now()) asc")) : nil
    erb :'list/index'
  end
end
