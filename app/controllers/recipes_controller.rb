class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    # @recipes = Recipe.all
    @recipes = Recipe.search(params[:search])
    @menus = Menu.all 
  end

  def recipe_kinds
    @recipe_kind = params[:r_kind]
    @kinds = Recipe.where(:kind => @recipe_kind)
  end

  def recipe_categories
    @category = params[:r_category]
    @category2 = CategorySelect.where(:category_number2 => "1", :menu_id => nil)
    @menu_category2 = CategorySelect.where(:category_number2 => "1", :recipe_id => nil)
    @category3 = CategorySelect.where(:category_number3 => "1", :menu_id => nil)
    @menu_category3 = CategorySelect.where(:category_number3 => "1", :recipe_id => nil)
    @category4 = CategorySelect.where(:category_number4 => "1", :menu_id => nil)
    @menu_category4 = CategorySelect.where(:category_number4 => "1", :recipe_id => nil)
    @category5 = CategorySelect.where(:category_number5 => "1", :menu_id => nil)
    @menu_category5 = CategorySelect.where(:category_number5 => "1", :recipe_id => nil)
    @category6 = CategorySelect.where(:category_number6 => "1", :menu_id => nil)
    @menu_category6 = CategorySelect.where(:category_number6 => "1", :recipe_id => nil)
    if @category == "2"
      @categories = @category2.map{|category2|category2.recipe}
      @menu_categories = @menu_category2.map{|menu_category2|menu_category2.menu}
      elsif @category == "3"
        @categories = @category3.map{|category3|category3.recipe}
        @menu_categories = @menu_category3.map{|menu_category3|menu_category3.menu}
      elsif @category == "4"
        @categories = @category4.map{|category4|category4.recipe}
        @menu_categories = @menu_category4.map{|menu_category4|menu_category4.menu}
      elsif @category == "5"
        @categories = @category5.map{|category5|category5.recipe}
        @menu_categories = @menu_category5.map{|menu_category5|menu_category5.menu}  
      elsif @category == "6"
        @categories = @category6.map{|category6|category6.recipe}
        @menu_categories = @menu_category6.map{|menu_category6|menu_category6.menu}               
    end
  end

  def calories
    # @calories = Recipe.find(:all, :conditions => { :category => 1 }) 
    # @menu_calories = Menu.find(:all, :conditions => { :category => 1 }) 
    @calories = Recipe.where.not(calorie: nil, pre_save: 1)
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
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
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
        category_selects_attributes: [:id, :category_number2, :category_number3, :category_number4, :category_number5, :category_number6],
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
