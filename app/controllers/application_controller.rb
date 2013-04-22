class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, ActionController::UnknownController,
      ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound,
      with: :render_error
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      [resource, :channels]
    elsif resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      super
    end
  end

  def error_404
    render_error
  end

  private

  def render_error
    message = "The page you were looking for doesn't exist.
     You may have mistyped the address or the page may have moved."

    redirect_to root_path, alert: message
  end
end
