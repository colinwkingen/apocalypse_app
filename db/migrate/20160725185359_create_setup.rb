class CreateSetup < ActiveRecord::Migration
  def change
    create_table(:amounts) do |t|
      t.column(:user_id, :int)
      t.column(:resource_id, :int)
      t.column(:quantity, :int)
      t.column(:unit, :varchar)
    end
    create_table(:resources) do |t|
      t.column(:name, :varchar)
      t.column(:cost, :float)
      t.column(:increment, :boolean)
    end
    create_table(:users) do |t|
      t.column(:name, :varchar)
      t.column(:money, :float)
      t.column(:high_score, :int)
      t.column(:scenario_name, :varchar)
    end
    create_table(:disasters) do |t|
      t.column(:name, :varchar)
    end
  end
end
