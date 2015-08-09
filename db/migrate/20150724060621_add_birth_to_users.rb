class AddBirthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth, :integer
  end
end
