class AboutController < ApplicationController
  def index
  	# @favorite_recipes = Favorite.favorite_count.map{|recipe_id| Recipe.find_by(id: recipe_id)}
    @favorite_recipes = Recipe.limit(3)
  	# @todays_menu = Menu.find(:last)
    @todays_menu = Menu.last

  	@todays_recipes = @todays_menu.recipes
    @main_recipe = @todays_recipes.select{|recipe| recipe.recipe_select == 1}.first
    @side_recipes = @todays_recipes.select{|recipe| recipe.recipe_select == 2}.compact
    # @side_recipes = @side_recipes
    # @count = @todays_recipes.count
    # @main_recipe = @main_recipes.first
    # @side1_recipe = @side1_recipes.first
    # @side2_recipe = @side2_recipes.first
    @nurtrition_menu = Menu.find(18)
    @nurtrition_menu2 = Menu.find(19)


    @permission_columns = Column.where(permission: 2)
    @columns = @permission_columns.limit(3)


    if user_signed_in?
      @permission = current_user.permission
    end
    require "date"

    @d = Date.today
  end
end
