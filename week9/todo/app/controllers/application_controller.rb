require "./config/environment"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
    register Sinatra::Flash
  end

  get "/" do
    @list ||= logged_in? ? current_user.todos.all() : nil
    erb :'list/index'
  end
end
