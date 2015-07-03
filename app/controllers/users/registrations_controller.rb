class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def new
    @user = User.new
    @u_n = params[:u_n]
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    file = params[:user][:image]
    @user.set_image(file)

    # respond_to do |format|
      if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @user }
        sign_up(resource_name, resource)
        redirect_to(user_path(@user))
      else
        # format.html { render action: 'new' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        render 'new'
      end
    # end
  end


  def update
   
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    
    #if update_resource(resource, account_update_params)
    if resource.update_without_current_password(account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :image, :gender, :email, :password, :password_confirmation, :nuntritionist_description, :permission, :height, :weight)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :image, :gender, :email, :password, :password_confirmation, :current_password, :nuntritionist_description, :permission, :height, :weight)
    end
  end

  def user_params
    params.require(:user).permit(:name, :image, :gender, :email, :password, :password_confirmation, :height, :weight)
  end






end
