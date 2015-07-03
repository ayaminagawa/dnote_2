class NutritionistsController < ApplicationController
  def show
    @nutritionist = Nutritionist.find(params[:id])
    @columns = Column.where(:nutritionist_id => params[:id])
  end

  def index
    @nutritionists = Nutritionist.all
  end

end
