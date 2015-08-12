class Users::SessionsController < Devise::SessionsController

  def new
    super
    @u_n = params[:u_n]
  end

end