class CreateABlurbColumnForResources < ActiveRecord::Migration
  def change
    add_column(:resources, :blurb, :string)
  end
end
