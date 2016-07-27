class Disaster < ActiveRecord::Base

  define_method(:every_day) do |user|
    message = ''
    if user.alive == false
      break
    end
    food_current = user.food_count.to_i
    water_current = user.water_count.to_i
    medicine_current = user.medicine_count.to_i
    protection_current = user.protection_count.to_i
    if self.name == 'Earthquake'
      user.update({food_count: (food_current - 9)})
      user.update({water_count: (water_current - 12)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 3)})
        user.update({protection_count: (protection_current - 3)})
      end
    end
    if self.name == 'Contagion'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 12)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 6)})
        user.update({protection_count: (protection_current - 6)})
      end
      if self.gas_mask?(user) && self.name == 'Contagion'
        user.update({alive: false})
      end
    end
    if self.name == 'Nuclear'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 15)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 6)})
        user.update({protection_count: (protection_current - 9)})
      end
      if self.hazmat_suit?(user) && self.name == 'Nuclear'
        user.update({alive: false})
      end
    end
    if (user.food_count.to_i < 0) || (user.water_count.to_i < 0)
      user.update({alive: false})
    elsif (user.medicine_count.to_i < 0) || (user.protection_count.to_i < 0)
      user.update({alive: false})
    else
      user.update({high_score: (user.high_score.to_i + 10)})
    end
  end

  define_method(:gas_mask?) do |user|
    resource_names = []
    chance_of_contagion = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    if resource_names.include?("Gas Mask")
      if rand(20) > 18
        chance_of_contagion = true
      end
    else
      if rand(20) > 9
        chance_of_contagion = true
      end
    end
    chance_of_contagion
  end

  define_method(:hazmat_suit?) do |user|
    resource_names = []
    chance_of_radiation = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    if resource_names.include?("Hazmat Suit")
      if rand(20) > 18
        chance_of_radiation = true
      end
    else
      if rand(20) > 9
        chance_of_radiation = true
      end
    end
    chance_of_radiation
  end
end
