class UsersController < Sinatra::Base

  configure do
    set :views, 'app/views/users'
  end

  get '/user' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    email = params['email']
    password = params['password']
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    email = params['email']
    password = params['password']
    full_name = params['full_name']
  end

end

# get '/list' do
#   "todo list page"
# end

# post '/list' do
#   # .. adding new record in db..
# end

# patch '/list' do
#   # .. update in db ..
# end

# delete '/list' do
#   # .. delete todo item ..
# end
