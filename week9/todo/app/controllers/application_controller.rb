require "./config/environment"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
  end

  get "/" do
    # Users.select('id', 'name').all
    erb :index
  end
end
