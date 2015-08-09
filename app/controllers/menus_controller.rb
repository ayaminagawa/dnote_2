class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu_recipes = @menu.menu_recipes
    @recipes = @menu.recipes
    @main_recipe = @recipes.select{|recipe| recipe.recipe_select == 1}.first
    @side_recipes = @recipes.select{|recipe| recipe.recipe_select == 2}
    @side_recipes = @side_recipes.compact
  end

  # GET /menus/new
  def new
    @menu = Menu.new
    @menu.menu_recipes.build 
    @main_menu_recipe_id = MenuRecipe.last.id + 1
    @main_recipes = current_user.recipes.where(recipe_select: 1 ).where.not(pre_save: 1)
    @side_recipes = current_user.recipes.where(recipe_select: 2 ).where.not(pre_save: 1)
    @menu.category_selects.build
  end

  # GET /menus/1/edit
  def edit
    @menu_recipes = @menu.menu_recipes
    @main_menu_recipe_id = @menu_recipes.first.id
    @main_recipes = current_user.recipes.where(recipe_select: 1 ) 
    @side_recipes = current_user.recipes.where(recipe_select: 2 )
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = current_user.menus.build(menu_params)
    @main_menu_recipe_id = MenuRecipe.last.id + 1
    @main_recipes = current_user.recipes.where(recipe_select: 1 ).where.not(pre_save: 1)
    @side_recipes = current_user.recipes.where(recipe_select: 2 ).where.not(pre_save: 1)
    # respond_to do |format|
    if @menu.save
        # @menu_recipe.menu_id = @menu.id
        redirect_to(menu_path(@menu))
      else
        render 'new'
      end
    end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
      if @menu.update(update_menu_params)
        redirect_to(menu_path(@menu))
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  
  def destroy
    @menu.destroy
    redirect_to root_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :point, :category, :image, category_selects_attributes: [:id, :category_number2, :category_number3, :category_number4, :category_number5, :category_number6], menu_recipes_attributes: [:id, :recipe_id])
    end

    def update_menu_params
      params.require(:menu).permit(:name, :point, :category, :image, category_selects_attributes: [:id, :category_number2, :category_number3, :category_number4, :category_number5, :category_number6])
    end
  end
