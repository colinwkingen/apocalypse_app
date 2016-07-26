require('spec_helper')

describe(Amount) do
  it('connects a user to a resource') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    new_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    expect(new_amount.quantity).to(eq(1))
  end

  it('finds an amount for a user/resource combination') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    test_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    found_amount = Amount.find_by(user_id: test_user.id, resource_id: test_resource.id)
    expect(found_amount.id).to(eq(test_amount.id))
  end
end
