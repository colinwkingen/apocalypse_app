class Resource < Activerecord::Base
  has_many :amounts
  has_many :users, through: :amounts
end
