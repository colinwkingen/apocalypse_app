require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + 'lib/*.rb'].each { |file| require file}

get('/') do
  @users = User.all()
erb(:index)


patch('/resource/:id/increment') do
  user = User.find(params['user_id'].to_i)
  resource = Resource.find(params['id'].to_i)
  if amount = Amount.find_by(user_id: user.id, resource_id: resource.id)
    if user.money >= resource.cost
      amount.update({:quantity => (amount.quantity + 1)})
      user.update({:money => (user.money - resource.cost)})
    else
      @money_message = "Money levels too low for purchase, current money:" + user.money.to_s
    end
  else
    if user.money >= resource.cost
      Amount.create({:user_id => user.id, :resource_id => resource_obj.id, :quantity => 1, :unit => resource_obj.unit})
    else
      @money_message = "Money levels too low for purchase, current money:" + user.money.to_s
    end
  redirect('')
end

patch('/resource/:id/decrement') do
  user = User.find(params['user_id'].to_i)
  resource = User.find(params['id'].to_i)
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
