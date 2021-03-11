class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :email, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :photo, :email, :password, :password_confirmation, :current_password)}
  end
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || profile_path(current_user)
  end

   include Pundit

  # Pundit: white-list approach.
   after_action :verify_authorized, except: :index, unless: :skip_pundit?
   after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

   def skip_pundit?
     devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
   end
end
