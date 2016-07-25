class User < ActiveRecord::Base
  has_many :amounts
  has_many :resources, through: :amounts
end
