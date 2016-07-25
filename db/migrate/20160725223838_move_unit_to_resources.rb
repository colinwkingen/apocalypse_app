class MoveUnitToResources < ActiveRecord::Migration
  def change
    remove_column(:amounts, :unit, :string)
    add_column(:resources, :unit, :string)
  end
end
