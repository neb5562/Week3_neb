class TodoController < ApplicationController

  get '/todo/new' do
    erb :'list/new'
  end

  get '/todo/:id/edit' do
    begin
      todo ||= Todo.find_by(id: params["id"])
    rescue ActiveRecord::RecordNotFound
      not_found
    end

    erb :'list/edit'
  end

  post '/todo' do
    result = TodoValidateService.new(params).call

    unless result.empty? 
      flash[:error_messages] = result
      redirect('/todo/new')
    else
      TodoService.new(params, current_user['id']).call 
      flash[:success_message] = 'To Do added successfully'
      redirect('/')
    end
  end

  patch '/todo' do
    # .. update in db ..
  end

  delete '/todo' do
    # .. delete todo item ..
  end

end
