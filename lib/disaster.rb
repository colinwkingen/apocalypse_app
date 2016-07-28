class Disaster < ActiveRecord::Base

  define_method(:every_day) do |user|
    if user.alive == false
      break
    end
    messages = ''
    if rand(3) > 1
      messages.concat(find_resources(user))
    end
    if self.name == 'Earthquake'
      user.update({food_count: (user.food_count.to_i - 12)})
      user.update({water_count: (user.water_count.to_i - 3)})
      if rand(3) > 1
        user.update({medicine_count: (user.medicine_count.to_i - 7)})
        user.update({protection_count: (user.protection_count.to_i - 7)})
        messages.concat("Feeling pretty bad today; had to use some of your medicine!")
      end
      if rand(20) < 2
        if self.hard_hat?(user) && self.name == 'Earthquake'
          user.update({alive: false})
          messages.concat("You have met your end due to falling debri!")
        else
          messages.concat("You have come in contact with falling debri, wise choice to have a hard hat!")
        end
      end
      if rand(5) == 3
        messages.concat("You're getting REALLY sick of rice and beans.!")
      end
      if rand(7) == 0
        messages.concat("Today there are a bunch of starving freaks trying to break in a steal your food.!")
      end
    end
    if self.name == 'Contagion'
      user.update({food_count: (user.food_count.to_i - 12)})
      user.update({water_count: (user.water_count.to_i - 3)})
      if rand(3) > 1
        user.update({medicine_count: (user.medicine_count.to_i - 9)})
        user.update({protection_count: (user.protection_count.to_i - 6)})
        messages.concat("Feeling kind of ill today; had to use a bunch of your medicine!")
      end
      if rand(20) < 2
        if self.gas_mask?(user) && self.name == 'Contagion'
          user.update({alive: false})
          messages.concat("You have met your end due to the contaminated air!")
        else
          messages.concat("You have come in contact with the contagion, wise choice to have a gas mask!")
        end
      end
      if rand(6) == 3
        messages.concat("You puked. Hopefully tomorrow will be a better day, but it probably won't be.!")
      end
      if rand(7) == 3
        messages.concat("Today there is a gang of infected people clawing at your door.!")
      end
    end
    if self.name == 'Nuclear'
      user.update({food_count: (user.food_count.to_i - 12)})
      user.update({water_count: (user.water_count.to_i - 3)})
      if rand(3) > 1
        user.update({medicine_count: (user.medicine_count.to_i - 6)})
        user.update({protection_count: (user.protection_count.to_i - 9)})
        messages.concat("Your skin is itchy; had to use some medicine!")
      end
      if rand(20) < 2
        if self.hazmat_suit?(user) && self.name == 'Nuclear'
          user.update({alive: false})
          messages.concat("You have met your end due to radioactive fallout!")
        else
          messages.concat("You have come in contact with radioactive fallout, wise choice to have a hazmat suit!")
        end
      end
      if rand(6) == 3
        messages.concat("All your friends and family are gone; why go on?!")
      end
      if rand(7) == 3
        messages.concat("All the basic infrastructure of civilization has collapsed. Good luck making a new life.!")
      end
    end
    if user.food_count.to_i < 0
      user.update({alive: false})
      messages.concat("You won't survive the apocalypse without enough food, you should BUY MORE BEANS!")
    elsif user.water_count.to_i < 0
      user.update({alive: false})
      messages.concat("You won't survive the apocalypse without enough water, you should BUY MORE FRESCA!")
    elsif user.medicine_count.to_i < 0
      user.update({alive: false})
      messages.concat("You won't survive the apocalypse without enough medicine, you should BUY MORE VICODIN!")
    elsif user.protection_count.to_i < 0
      user.update({alive: false})
      messages.concat("You won't survive the apocalypse without enough protection, you should BUY MORE RUBBER GLOVES!")
    end
    self.update({message: messages})
  end

  define_method(:find_resources) do |user|
    message = ''
    int = rand(6)
    if int < 2
      user.update({food_count: (user.food_count.to_i + 12)})
      message.concat("Lucky you, you found some food to add to your stockpile!")
    elsif int < 4
      user.update({water_count: (user.water_count.to_i + 12)})
      message.concat("Lucky you, you found some water to add to your stockpile!")
    elsif int < 5
      user.update({medicine_count: (user.medicine_count.to_i + 6)})
      message.concat("Lucky you, you found some medicine to add to your stockpile!")
    elsif int < 6
      user.update({protection_count: (user.protection_count.to_i + 6)})
      message.concat("Lucky you, you found some protection to add to your stockpile!")
    end
    message
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

  define_method(:hard_hat?) do |user|
    resource_names = []
    chance_of_debri = false
    user.resources.each() do |resource|
      resource_names.push(resource.name)
    end
    unless resource_names.include?("Hard Hat")
      chance_of_debri = true
    end
    chance_of_debri
  end

  define_method(:choices_writter) do
    messages = nil
    if (self.name == "Earthquake") && (rand(10) > 8)
      messages = ["You have stumbled upon a  well stocked pantry, there is food, but the building is crumbling...what do you do?", ["Quickly stuff your backpack with as much as you can", "Grab a handful of items and make a run for it", "Flee in terror"]]
    end
    messages
  end

  define_method(:choices_reader) do |user, value|
    message = ''
    if (self.name == "Earthquake")
      if value == 0
        break
      elsif value == 1
        user.update({alive: false})
        message.concat("You did not make it out of the crumbling building in time")
      elsif value == 2
        user.update({food_count: (user.food_count.to_i + 12)})
        message.concat("You have made it out alive with the food that you grabbed")
      elsif value == 3
        user.update({medicine_count: (user.medicine_count.to_i - 6)})
        message.concat("You made it out alive, but in your panic, you twisted your ankle requiring you to expend valuable medicine")
      end
    end
    message
  end

end
