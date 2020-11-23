class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  @unread_notifications = Notification.where(seen: false).count
  before_action :authenticate_user!

  protected

  rescue_from CanCan::AccessDenied do |exception|

    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.procedures_path, alert: 'No tienes permisos para acceder a esta página' }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

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
