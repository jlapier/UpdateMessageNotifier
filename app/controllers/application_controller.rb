class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_is_admin?
    current_user and current_user.is_admin?
  end

  helper_method :current_user

  def require_admin
    unless user_is_admin?
      flash[:error] = "You are not authorized to access that page."
      redirect_to root_url
    end
  end
end
