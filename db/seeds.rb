require("./lib/resource")
require("./lib/disaster")

Resource.create({name: "Beans", cost: 1.29, incrementable: true, unit: "Can", item_type: "Food", value: 3})
Resource.create({name: "Bottled Water", cost: 15.00, incrementable: true, unit: "Gallon", item_type: "Water", value: 3})
Resource.create({name: "Black Cherry Fresca", cost: 1.79, incrementable: true, unit: "Can", item_type: "Water", value: 3})
Resource.create({name: "Vicodin", cost: 5.00, incrementable: true, unit: "Pill", item_type: "Medicine", value: 3})
Resource.create({name: "Jar of Pickles", cost: 3.59, incrementable: true, unit: "Jar", item_type: "Food", value: 3})
Resource.create({name: "Life Jacket", cost: 20.00, incrementable: false, unit: "Jacket", item_type: "Protection", value: 3})
Resource.create({name: "Rubber Gloves", cost: 2.59, incrementable: true, unit: "Pair", item_type: "Protection", value: 3})

Disaster.create({name: 'Earthquake'})
Disaster.create({name: 'Contagion'})
Disaster.create({name: 'Nuclear'})
