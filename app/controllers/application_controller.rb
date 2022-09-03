class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, if: Proc { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc { |c| c.request.format == 'application/json' }
  # before_action :authenticate_user!

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :bio, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :bio, :email, :password, :current_password)
    end
  end
end
