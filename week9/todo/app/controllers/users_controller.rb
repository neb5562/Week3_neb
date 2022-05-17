class UsersController < ApplicationController

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
    register Sinatra::Flash
  end

  get '/user/index' do
    erb :'users/index'
  end


end
