class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user && current_user.wishlists.any?
      @wishlists = current_user.wishlists.all
    end
  end

  def destroy
    id = params[:id]
    @wishlist = Wishlist.find_by(id: id)
    @wishlist.destroy
    flash[:danger] = "Item Removed"
    redirect_to "/wishlist"
  end
end


# def index
#     if current_user && current_user.carted_products.where(status: "carted").any?
#       @carted_products = current_user.carted_products.where(status: "carted")
#       @subtotal = calculate_subtotal(@carted_products)
#       @tax = calculate_tax(@carted_products)
#       @total = @subtotal + @tax
#       if params[:remove]
#         @remove = @carted_products.find_by(id: params[:remove])
#         @remove.update(status: "removed")
#       end
#     else
#       redirect_to "/"
#     end
#   end