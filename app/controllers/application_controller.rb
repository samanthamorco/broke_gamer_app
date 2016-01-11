class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

private

  def authenticate_admin!
    redirect_to "/" unless current_user && (current_user.admin? || current.user.mod?)
    flash[:danger] = "Please don't hack me D:" unless current_user && (current_user.admin? || current.user.mod?)
  end
  
end
