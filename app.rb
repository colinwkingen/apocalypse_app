require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get('/') do
  @users = User.all()
erb(:index)
end

patch('/users/:user_id/resources/:resource_id/increment') do
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

patch('/users/:user_id/resources/:resource_id/decrement') do
  user = User.find(params['user_id'].to_i)
  resource = Resource.find(params['resource_id'].to_i)
  if amount = Amount.find_by(user_id: user.id, resource_id: resource.id)
    if amount.quantity > 1
      amount.update({:quantity => (amount.quantity - 1)})
      user.update({:money => (user.money + resource.cost)})
    else
      amount.destroy
      user.update({:money => (user.money + resource.cost)})
    end
  end
  redirect('/users/' + user.id.to_s)
end

patch('/users/:user_id/resources/:resource_id/remove') do
  user = User.find(params['user_id'].to_i)
  resource = Resource.find(params['resource_id'].to_i)
  amount = Amount.find_by(user_id: user.id, resource_id: resource.id)
  amount.destroy
  user.update({:money => (user.money + resource.cost)})
  redirect('/users/' + user.id.to_s)
end

post('/new_user') do
  User.create({name: params['new_user']})
  redirect to('/')
end

get('/users/:id') do
  @user = User.find(params['id'])
  @purchased_resource_names = []
  @resources = []
  @inventory = @user.resources
  @disasters = Disaster.all()
  @inventory.each do |resource|
    @purchased_resource_names.push(resource.name)
  end
  Resource.all.each do |resource|
    unless @purchased_resource_names.include?(resource.name)
      @resources.push(resource)
    end
  end
  @resources = @resources.sort_by do |resource|
    resource[:id]
  end
  @bottleneck = @user.bottleneck_resource()
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
  if user.money > item.cost
    new_amount = Amount.create({:user_id => user.id, :resource_id => item.id, :quantity => 1})
    user.update({:money => (user.money - item.cost)})
  end
  redirect('/users/' + user.id.to_s)
end

get('/users/:user_id/disasters/:disaster_id') do
  @user = User.find(params['user_id'])
  @disaster = Disaster.find(params['disaster_id'])
  @counter = 0
  @this_high_score = @user.high_score
  @user.alive = true
  @user.compile_resources
  @special_items = []
  @user.resources.each do |resource|
    if resource.item_type == 'Special'
      @special_items.push(resource)
    end
  end
  erb(:disaster)
end

post('/users/:user_id/disasters/:disaster_id/:counter_id') do
  @user = User.find(params['user_id'])
  @disaster = Disaster.find(params['disaster_id'])
  @counter = params['counter_id'].to_i
  value = params['choice_radio'].to_i
  # if @user.high_score.to_i < (@counter + 1)
  #   @user.update({high_score: (@counter + 1)})
  # end
  if @user.alive == true
    if (radios = @disaster.choices_writer) && @user.event_flag
      @scenario = radios[0]
      @multiple_choice = radios[1]
    end
    @disaster.every_day(@user)
    @counter += 1
    @message_arry = @disaster.message.split('!')
    if (value > 0) && @user.event_flag
      @message_arry.push(@disaster.choices_reader(@user, value))
    end
  else
    if @user.high_score.to_i < (@counter + 1)
      @user.update({high_score: (@counter + 1)})
    end
    @message_arry = @disaster.message.split('!')
  end
  @special_items = []
  @user.resources.each do |resource|
    if resource.item_type == 'Special'
      @special_items.push(resource)
    end
  end
  erb(:disaster)
end
