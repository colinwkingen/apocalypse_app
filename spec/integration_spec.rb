require('spec_helper')

describe 'the create user route', {:type => :feature} do
  it 'creates a new user' do
    visit('/')
    fill_in('new_user', with: 'Bacon Boy')
    click_button('New User')
    expect(page).to have_content('Bacon Boy')
  end

  it 'visits a users store page and displays their money property' do
    test_user = User.create({name: 'Mike'})
    visit('/')
    click_link(test_user.name)
    expect(page).to have_content(test_user.name)
    expect(page).to have_content(test_user.money)
  end
end

describe('the store route', {:type => :feature}) do
  it('creates an amount for a given user and a given resource') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    expect(page).to have_content("Current Items:")
    expect(page).to have_content("Beans - 1.29")
    expect(page).to have_content("1")
  end

  it('increments the quanity up when you click the up arrow') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    5.times do
      click_button('up_button')
    end
    expect(page).to have_content("6")
  end

  it 'tells you what items youre lacking' do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Gallon Jug of Water", cost: 5.79, incrementable: true, unit: "Package", item_type: "Water", value: 8, blurb: "Humans require about one gallon of water a day."})
    Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    expect(page).to have_content("You are most lacking : | Food | | Medicine | | Protection |")
  end
end

describe('the disaster route', {:type => :feature}) do
  it('allows you to play out a disaster') do
    Disaster.create({name: 'Earthquake'})
    test_user = User.create({name: 'Bob', alive: true})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    click_link('Earthquake')
    click_button("Go!")
    expect(page).to have_content("You died on day 1")
  end

  it 'tells you if you did not purchase special items for a disaster' do
    test_disaster = Disaster.create({name: 'Earthquake'})
    test_user = User.create({name: 'Bob', alive: true})
    visit('/users/' + test_user.id.to_s + '/disasters/' + test_disaster.id.to_s)
    expect(page).to have_content("WARNING: You did not purchase any special items to help you survive the Earthquake Disaster")
  end
end
