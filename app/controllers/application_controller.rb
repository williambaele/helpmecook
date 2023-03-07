class ApplicationController < ActionController::Base
  include Pundit::Authorization

  add_flash_types :info, :error, :success
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name pseudo photo])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[last_name first_name pseudo photo])
  end

  def after_sign_up_path_for(resource)
    sign_in(resource)
    flash[:success] = 'Account created and signed in'
    root_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path
    flash[:success] = 'Your account has been updated successfully'
  end

  def after_sign_in_path_for(resource)
    flash[:success] = 'Logged in'
    root_path
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
