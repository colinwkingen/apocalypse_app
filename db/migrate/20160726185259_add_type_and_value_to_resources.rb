class AddTypeAndValueToResources < ActiveRecord::Migration
  def change
    add_column(:resources, :item_type, :string)
    add_column(:resources, :value, :int)
  end
end
