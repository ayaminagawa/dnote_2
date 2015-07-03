class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipe
	belongs_to :menu

	def self.favorite_count
   Favorite.group(:recipe_id).order('count_recipe_id desc').limit(3).count('recipe_id').keys
 end


end
