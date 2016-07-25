class EditIncrementColumn < ActiveRecord::Migration
  def change
    rename_column :resources, :increment, :incrementable
  end
end
