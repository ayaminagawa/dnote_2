class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :header_permission

  def after_sign_in_path_for(resource)
       case resource
      when User
        user_path(current_user)
      when AdminUser
        admin_root_path
      end
  end
# def after_sign_in_path_for(resource)
  #   if　current_user.present? && current_user.permission == nil
  #      nutritionist_show_path(current_user)
  #     elsif current_user.present?
  #      user_path(current_user)
  #   end
  # end

  def header_permission
    if user_signed_in?
      @permission = current_user.permission
    end
  end


  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
     u.permit(:name, :image, :gender, :email, :password, :password_confirmation)
   end

 end



end
