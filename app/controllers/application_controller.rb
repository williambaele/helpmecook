class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success
  
  def after_sign_up_path_for(resource)
    sign_in(resource)
    flash[:success] = "Account created and signed in"
    root_path
  end

  def after_sign_in_path_for(resource)
    flash[:success] = "Logged in"
    root_path
  end
end
