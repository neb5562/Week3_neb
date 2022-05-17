class ListController < ApplicationController

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "todo"
    register Sinatra::Flash
  end

  get '/list/new' do
    erb :'list/new'
  end

  post '/list' do
    result = TodoValidateService.new(params).call

    unless result.empty? 
      flash[:error_messages] = result
      redirect('/list/new')
    else
      ListService.new(params, current_user['id']).call 
      flash[:success_message] = 'To Do added successfully'
      redirect('/')
    end
  end

  patch '/list' do
    # .. update in db ..
  end

  delete '/list' do
    # .. delete todo item ..
  end

end
