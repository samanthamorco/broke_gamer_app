class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 

  before_filter :check_deal_status, :check_wishlist

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
    flash[:danger] = "You must be a moderator or admin to access this." unless current_user && (current_user.admin? || current.user.mod?)
  end

  def check_deal_status
    deals = Deal.where(status: "active")
    deals.each do |deal|
      if Time.now > deal.date
        deal.update(status: "inactive")
      end
    end
  end

  def check_wishlist
    if current_user && current_user.wishes.any?
      wishes = current_user.wishes.all

      deals = Deal.where(status: "active")
      wishes.each do |wish|
        deals.each do |deal|
          if wish.product_id == deal.product_id
            if (wish.price >= deal.price) && (wish.notified == false)
              flash[:success] = "#{wish.product_name} is on sale for $#{deal.price}!"
              UserMailer.notify_user(current_user, wish.product_name, deal).deliver_now
              wish.update(notified: true)
            end
          end
        end
      end
    end
    

  end
  
end
