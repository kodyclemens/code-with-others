# Helper methods defined in this controller
# Used throughout child controllers
class ApplicationController < ActionController::Base
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id] ? true : false
  end

  def require_login
    return if logged_in?

    flash[:error] = 'You must be logged in to access this section'
    redirect_to root_path
  end
end
