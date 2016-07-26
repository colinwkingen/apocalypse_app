require('spec_helper')

describe(User) do
  it "tests to see if a user will increment resource counts" do
    test_user = User.create({name: 'Mike'})
    test_resource_food = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can", item_type: "Food", value: 3})
    test_resource_water = Resource.create({name: "Monster", cost: 1.29, incrementable: true, unit: "Can", item_type: "Water", value: 3})
    test_resource_medicine = Resource.create({name: "Vicodin", cost: 1.29, incrementable: true, unit: "Pill", item_type: "Medicine", value: 3})
    test_resource_protection = Resource.create({name: "Rubber Gloves", cost: 1.29, incrementable: true, unit: "Pair", item_type: "Protection", value: 3})
    test_amount1 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_food.id, :quantity => 7})
    test_amount2 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_water.id, :quantity => 7})
    test_amount3 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_medicine.id, :quantity => 7})
    test_amount4 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_protection.id, :quantity => 7})
    test_user.compile_resources()
    expect(test_user.food_count()).to(eq(21))
  end
end
