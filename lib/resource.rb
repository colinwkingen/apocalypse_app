class Resource < ActiveRecord::Base
  has_many :amounts
  has_many :users, through: :amounts

  define_singleton_method(:populate_items) do
    Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can", value: 2, item_type: "Food"})
    Resource.create({name: "Black Cherry Fresca", cost: 1.79, incrementable: true, unit: "Can", value: 2, item_type: "Water"})
    Resource.create({name: "Vicodin", cost: 5.00, incrementable: true, unit: "Pill", value: 2, item_type: "Protection"})
    Resource.create({name: "Jar of Pickles", cost: 3.59, incrementable: true, unit: "Jar", value: 2, item_type: "Food"})
    Resource.create({name: "Life Jacket", cost: 20.00, incrementable: false, unit: "Jacket", value: 2, item_type: "Protection"})
    Resource.create({name: "Rubber Gloves", cost: 2.59, incrementable: true, unit: "Pair", value: 2, item_type: "Protection"})
  end
end
