class Disaster < ActiveRecord::Base

  define_method(:every_day) do |user|
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
    end
    if self.name == 'Nuclear'
      user.update({food_count: (food_current - 12)})
      user.update({water_count: (water_current - 15)})
      if rand(3) > 1
        user.update({medicine_count: (medicine_current - 6)})
        user.update({protection_count: (protection_current - 9)})
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
end
