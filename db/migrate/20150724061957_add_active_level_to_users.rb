class AddActiveLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_level, :integer
  end
end
