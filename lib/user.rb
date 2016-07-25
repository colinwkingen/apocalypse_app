class User < ActiveRecord::Base
  has_many :amounts
  has_many :resources, through: :amounts
  before_save(:set_money)

private
  define_method(:set_money) do
    self.money = rand(1000.00..2000.00).round(2)
  end
end
