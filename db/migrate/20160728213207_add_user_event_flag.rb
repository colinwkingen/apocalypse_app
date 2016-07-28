class AddUserEventFlag < ActiveRecord::Migration
  def change
    add_column(:users, :event_flag, :boolean)
  end
end
