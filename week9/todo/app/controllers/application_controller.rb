require "./config/environment"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
  end

  get "/" do
    # session['user_id'] = 10
    erb :index
  end
end
