require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

Resource.populate_items()

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
  @inventory = Resource.all()
  erb(:user)
end

delete('/users/:id') do
  user = User.find(params['id'])
  user.destroy()
  redirect('/')
end

delete('/users/:user_id/resources/:resource_id') do
  item = Resource.find(params['resource_id'])
  item.destroy()
  redirect('/users/' + params['user_id'])
end
