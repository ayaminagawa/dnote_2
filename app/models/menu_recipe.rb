class MenuRecipe < ActiveRecord::Base
	belongs_to :menu, :class_name => "Menu"
	belongs_to :recipe
end
