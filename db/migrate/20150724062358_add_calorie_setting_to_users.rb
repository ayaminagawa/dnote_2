class AddCalorieSettingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :calorie_setting, :integer
  end
end
