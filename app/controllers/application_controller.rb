class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 

  after_filter :set_csrf_cookie_for_ng

def set_csrf_cookie_for_ng
  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
end

protected

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def authenticate_admin!
    redirect_to "/" unless current_user && (current_user.admin? || current.user.mod?)
    flash[:danger] = "Please don't hack me D:" unless current_user && (current_user.admin? || current.user.mod?)
  end
  
end
