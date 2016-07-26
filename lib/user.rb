class User < ActiveRecord::Base
  has_many :amounts
  has_many :resources, through: :amounts
  before_create(:set_money)

  define_method(:compile_resources) do
    self.resources.each() do |resource|
      amount = Amount.find_by(user_id: self.id, resource_id: resource.id)
      if resource.item_type == 'Food'
        self.update({food_count: (resource.value * amount.quantity)})
      elsif resource.item_type == 'Medicine'
        self.update({medicine_count: (resource.value * amount.quantity)})
      elsif resource.item_type == 'Protection'
        self.update({protection_count: (resource.value * amount.quantity)})
      elsif resource.item_type == 'Water'
        self.update({water_count: (resource.value * amount.quantity)})
      end
    end
  end

private
  define_method(:set_money) do
    self.money = rand(1000.00..2000.00).round(2)
  end
end
