class AddResourceValuesToUser < ActiveRecord::Migration
  def change
    add_column(:users, :food_count, :int)
    add_column(:users, :water_count, :int)
    add_column(:users, :medicine_count, :int)
    add_column(:users, :protection_count, :int)
  end
end
