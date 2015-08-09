class RemoveBirthToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birth, :integer
  end
end
