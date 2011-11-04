class ApplicationController < ActionController::Base
  helper :application

  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_is_admin?
    current_user and current_user.is_admin?
  end

  def most_recent_update
    @most_recent_update ||= UpdateMessage.published.first
  end

  helper_method :current_user, :user_is_admin?, :most_recent_update

  def require_admin
    unless user_is_admin?
      flash[:error] = "You are not authorized to access that page."
      redirect_to root_url
    end
  end
end
