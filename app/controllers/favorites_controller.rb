class FavoritesController < ApplicationController

  # before_action :signed_in_user
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorite_recipe!(@recipe)
  end

  def destroy
    @recipe = Favorite.find(params[:id]).recipe
    current_user.unfavorite_recipe!(@recipe)
  end
end
