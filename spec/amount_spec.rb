require('spec_helper')

describe(Amount) do
  it('connects a user to a resource') do
    test_user = User.create({name: 'Mike'})
    test_resource = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can"})
    new_amount = Amount.create({:user_id => test_user.id, :resource_id => test_resource.id, :quantity => 1})
    expect(new_amount.quantity).to(eq(1))
  end
end
