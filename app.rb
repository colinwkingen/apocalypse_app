require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get('/') do
  @users = User.all()
  erb(:index)
end

post('/new_user') do
  User.create({name: params['new_user']})
  redirect to('/')
end

get('/users/:id') do
  @user = User.find(params['id'])
  erb(:user)
end

delete('/users/:id') do
  user = User.find(params['id'])
  user.destroy()
  redirect('/')
end
