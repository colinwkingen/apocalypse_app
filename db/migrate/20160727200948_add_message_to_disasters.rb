class AddMessageToDisasters < ActiveRecord::Migration
  def change
    add_column(:disasters, :message, :varchar)
  end
end
