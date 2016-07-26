require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

Resource.populate_items()

get('/') do
  @users = User.all()
erb(:index)
end

patch('/users/:user_id/resource/:resource_id/increment') do
  user = User.find(params['user_id'].to_i)
  resource = Resource.find(params['resource_id'].to_i)
  if amount = Amount.find_by(user_id: user.id, resource_id: resource.id)
    if user.money >= resource.cost
      amount.update({:quantity => (amount.quantity + 1)})
      user.update({:money => (user.money - resource.cost)})
    else
      @money_message = "Money levels too low for purchase, current money:" + user.money.to_s
    end
  else
    if user.money >= resource.cost
      Amount.create({:user_id => user.id, :resource_id => resource.id, :quantity => 1})
    else
      @money_message = "Money levels too low for purchase, current money:" + user.money.to_s
    end
  end
  redirect('/users/' + user.id.to_s)
end

patch('/users/:user_id/resource/:resource_id/decrement') do
  user = User.find(params['user_id'].to_i)
  resource = User.find(params['resource_id'].to_i)
  if amount = Amount.find_by(user_id: user.id, resource_id: resource.id)
    if amount.quantity > 0
      amount.update({:quantity => (amount.quantity - 1)})
      user.update({:money => (user.money + resource.cost)})
    else
      amount.destroy
      user.update({:money => (user.money + resource.cost)})
    end
  end
  redirect('')
end

post('/new_user') do
  User.create({name: params['new_user']})
  redirect to('/')
end

get('/users/:id') do
  @user = User.find(params['id'])
  @resources = Resource.all()
  @inventory = @user.resources
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

post('/users/:user_id/resources/:resource_id') do
  item = Resource.find(params['resource_id'])
  user = User.find(params['user_id'])
  new_amount = Amount.create({:user_id => user.id, :resource_id => item.id, :quantity => 1})
  redirect('/users/' + user.id.to_s)
end
