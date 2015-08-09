class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    @menus = Menu.all 
  end

  def recipe_kinds
    @recipe_kind = params[:r_kind]
    @kinds = Recipe.where(:kind => @recipe_kind)
  end

  def recipe_categories
    @category = params[:r_category]
    @categories = CategorySelect.where(:category => @category, :menu_id => nil).map{|category|category.recipe}
    @menu_categories = CategorySelect.where(:category => @category, :recipe_id => nil).map{|category|category.menu}
  end

  def calories
    # @calories = Recipe.find(:all, :conditions => { :category => 1 }) 
    # @menu_calories = Menu.find(:all, :conditions => { :category => 1 }) 
    @calories = Recipe.where.not(calorie: nil, pre_save: 1)
  end

  def search
    @search_recipes = Recipe.search(params[:search])
    @search_menus = Menu.search(params[:search])
  end


  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @made_reports = MadeReport.find(:all, :conditions => { :recipe_id => params[:id] }) 
    @ingredients = Ingredient.find(:all, :conditions => { :recipe_id => params[:id]})
    @procedures = Procedure.find(:all, :conditions => { :recipe_id => params[:id]})
    @recommended_recipe = Recipe.where(pre_save: 0).last
    @made_report = MadeReport.new
    @made_report_number = @recipe.made_reports.count
    # @recommended_recipe = @recommended_recipe.find(:last)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    6.times{@recipe.ingredients.build}
    4.times{@recipe.procedures.build}
    @recipe.category_selects.build
    # 7.times{@recipe.recipe_feelings.build}
    # @ingredient = Ingredient.new
    # @category_select = CategorySelect.new(params[:category])  
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    # @recipe = Recipe.new(recipe_params)
    @recipe = current_user.recipes.build(recipe_params)
    # @recipe.ingredients.build
    # @category_select = @recipe.category_select.build(params[:category])
    if params[:save]
     @recipe.pre_save = 0
    elsif params[:pre_save]
     @recipe.pre_save = 1
    end

    if @recipe.save
      # @ingredient = @recipe.ingredients.build
      # # @menu_recipe.menu_id = @menu.id
      # # @menu_recipe.recipe_id = params[:main]
      # @category_select.save

      # @ingredient.save
      redirect_to(recipe_path(@recipe))
    else
      render 'new'
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    if params[:save]
     @recipe.pre_save = 0
    elsif params[:pre_save]
     @recipe.pre_save = 1
    end

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    redirect_to '/about'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :description, :recipe_select, :tip, :image, :calorie, :kind, :people, :sugar, 
        category_selects_attributes: [:id, :category],
        ingredients_attributes: [:id, :name, :volume], procedures_attributes: [:id, :body, :image], 
        recipe_feelings_attributes: [:id, :feeling],
        )
    end

    # def ingredient_params
    #   params.require(:ingredient).permit(:name, :volume)
    # end
    def correct_user
      @Recipe = Recipe.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@recipe.user)
    end
  end
