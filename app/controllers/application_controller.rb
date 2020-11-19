class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    #current_user.is_a?(Admin) ? admin_tests_path : (stored_location_for(resource) || root_path)
    procedures_path
  end

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_path, alert: "You don't have admin permissions."
    end
  end
end
