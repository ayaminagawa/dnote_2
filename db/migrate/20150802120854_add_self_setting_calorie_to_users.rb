class AddSelfSettingCalorieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :self_setting_calorie, :integer
  end
end
