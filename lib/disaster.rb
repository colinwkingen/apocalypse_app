class Disaster < ActiveRecord::Base

  define_method(:every_day) do |user|
    messages = ''
    if user.alive == false
      break
    end
    food_current = user.food_count.to_i
    water_current = user.water_count.to_i
    medicine_current = user.medicine_count.to_i
    protection_current = user.protection_count.to_i
    if self.name == 'Earthquake'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 3)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 7)})
        user.update({protection_count: (protection_current - 7)})
      end
      if self.life_jacket?(user) && self.name == 'Earthquake'
        user.update({alive: false})
      end
    end
    if self.name == 'Contagion'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 3)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 9)})
        user.update({protection_count: (protection_current - 6)})
      end
      if rand(4) > 2
        if self.gas_mask?(user) && self.name == 'Contagion'
          user.update({alive: false})
          message.concat("You have met your end due to the contaminated air/")
        else
          message.concat("You have come in contact with the contagion, wise choice to have a gas mask/")
        end
      end
    end
    if self.name == 'Nuclear'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 3)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 6)})
        user.update({protection_count: (protection_current - 9)})
      end
      if rand(4) > 2
        if self.hazmat_suit?(user) && self.name == 'Nuclear'
          user.update({alive: false})
          message.concat("You have met your end due to radioactive fallout/")
        else
          message.concat("You have come in contact with radioactive fallout, wise choice to have a hazmat suit/")
        end
      end
    end
    if user.food_count.to_i < 0
      user.update({alive: false})
      message.concat("You won't survive the apocalypse without enough food, you should BUY MORE BEANS/")
    elsif user.water_count.to_i < 0
      user.update({alive: false})
      message.concat("You won't survive the apocalypse without enough water, you should BUY MORE FRESCA/")
    elsif user.medicine_count.to_i < 0
      user.update({alive: false})
      message.concat("You won't survive the apocalypse without enough medicine, you should BUY MORE VICODIN/")
    elsif user.protection_count.to_i < 0
      user.update({alive: false})
      message.concat("You won't survive the apocalypse without enough protection, you should BUY MORE RUBBER GLOVES/")
    else
      user.update({high_score: (user.high_score.to_i + 10)})
    end
    self.update({message: messages})
  end

  define_method(:gas_mask?) do |user|
    resource_names = []
    chance_of_contagion = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    unless resource_names.include?("Gas Mask")
      chance_of_contagion = true
    end
    chance_of_contagion
  end

  define_method(:hazmat_suit?) do |user|
    resource_names = []
    chance_of_radiation = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    unless resource_names.include?("Hazmat Suit")
      chance_of_radiation = true
    end
    chance_of_radiation
  end

  define_method(:life_jacket?) do |user|
    resource_names = []
    chance_of_drowning = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    if resource_names.include?("Life Jacket")
      if rand(20) > 18
        chance_of_drowning = true
      end
    else
      if rand(20) > 9
        chance_of_drowning = true
      end
    end
    chance_of_drowning
  end
end
