class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  

  # GET /users
  # GET /users.json
  def index
    @nutritionists = User.where(:permission => 1..2)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @id = params[:id]
    @main_recipes = Recipe.where(:user_id => @id, :recipe_select => "1")
    @sub_recipes = Recipe.where(:user_id => @id, :recipe_select => "2" )
    @recipes = Recipe.where(:user_id => @id)

    @menus = Menu.find(:all, :conditions => { :user_id => @id})
    @made_reports = MadeReport.find(:all, :conditions => { :user_id => @id})
    @user = User.find(@id)
    @favorite_recipes = @user.favorites.map {|favorite| favorite.recipe }
  end

  def nutritonist_show
    @user = current_user
    @columns = Column.where(:user_id => params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    file = params[:user][:image]
    @user.set_image(file)

    respond_to do |format|
      if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @user }
        redirect_to(user_path(@user))
      else
        # format.html { render action: 'new' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        raise
        render 'new'
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    file = params[:user][:image]
    @user.set_image(file)
    raise

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def favorite_recipe
    @title = 'Favorite Recipes'
    @recipe = current_user.recipes.build
    # @feed_tweets = current_user.favorite_tweets.paginate(page: params[:page])
    render template: 'about/index'
  end

  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :image, :gender, :email, :password, :password_confirmation, :height, :weight)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  end
