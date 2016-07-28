require('spec_helper')

describe(Disaster) do
  it "tests to see if a user will survive the correct number of days for the given disaster" do
    test_disaster = Disaster.create({name: 'Contagion'})
    test_user = User.create({name: 'Mike'})
    test_resource_food = Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can", item_type: "Food", value: 3})
    test_resource_water = Resource.create({name: "Monster", cost: 1.29, incrementable: true, unit: "Can", item_type: "Water", value: 3})
    test_resource_medicine = Resource.create({name: "Vicodin", cost: 1.29, incrementable: true, unit: "Pill", item_type: "Medicine", value: 3})
    test_resource_protection = Resource.create({name: "Rubber Gloves", cost: 1.29, incrementable: true, unit: "Pair", item_type: "Protection", value: 3})
    test_resource_key_item = Resource.create({name: "Gas Mask", cost: 1.29, incrementable: false, unit: "Mask", item_type: "Specialty", value: 3})
    test_amount1 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_food.id, :quantity => 70})
    test_amount2 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_water.id, :quantity => 40})
    test_amount3 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_medicine.id, :quantity => 70})
    test_amount4 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_protection.id, :quantity => 70})
    test_amount5 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_key_item.id, :quantity => 1})
    test_user.compile_resources()
    6.times() do
      test_disaster.every_day(test_user)
    end
    expect(test_user.high_score()).to(eq(6))
  end
  it "tests to see if a disaster will kill someone" do
    test_disaster = Disaster.create({name: 'Earthquake'})
    test_user = User.create({name: 'Mike', alive: true})
    test_disaster.every_day(test_user)
    expect(test_user.alive()).to(eq(false))
  end
  it "tests to see if a resource will save someone" do
    test_disaster = Disaster.create({name: 'Earthquake'})
    test_user = User.create({name: 'Mike', alive: true})
    test_resource_food = Resource.create({name: "Rubber Gloves", cost: 1.29, incrementable: true, unit: "Pair", item_type: "Food", value: 3})
    test_resource_water = Resource.create({name: "Monster", cost: 1.29, incrementable: true, unit: "Can", item_type: "Water", value: 3})
    test_resource_medicine = Resource.create({name: "Vicodin", cost: 1.29, incrementable: true, unit: "Pill", item_type: "Medicine", value: 3})
    test_resource_protection = Resource.create({name: "Rubber Gloves", cost: 1.29, incrementable: true, unit: "Pair", item_type: "Protection", value: 3})
    test_amount1 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_food.id, :quantity => 7})
    test_amount2 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_water.id, :quantity => 7})
    test_amount3 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_medicine.id, :quantity => 7})
    test_amount4 = Amount.create({:user_id => test_user.id, :resource_id => test_resource_protection.id, :quantity => 7})
    test_user.compile_resources()
    test_disaster.every_day(test_user)
    expect(test_user.alive()).to(eq(true))
  end
end
