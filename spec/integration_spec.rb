require('spec_helper')

describe('the create amount route', {:type => :feature}) do
  it('creates an amount for a given user and a given resource') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    click_button('Buy')
    expect(page).to have_content("Quantity: 1")
  end
end

describe('the increment route', {:type => :feature}) do
  it('increments the quanity up when you click the up arrow') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    visit('/users/' + test_user.id.to_s)
    save_and_open_page
    click_button('up_button')
    expect(page).to have_content("Quantity: 2")
  end
end
