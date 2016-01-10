class Api::V1::WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user && current_user.wishlists.any?
      @wishlists = current_user.wishlists.all
      @wishlists = @wishlists.sort_by {|product| product.priority}
    end
  end

  def show
    @wishlist = Wishlist.find(params[:id])
  end

  def destroy
    id = params[:id]
    @wishlist = Wishlist.find_by(id: id)
    @wishlist.destroy
    flash[:danger] = "Item Removed"
    redirect_to "/wishlist"
  end

  def new
    id = params[:id]
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Wishlist.new(product_id: params[:product_id], product_name: params[:product_name], price: params[:price], user_id: current_user.id)
    if @wishlist.save
      flash[:success] = "Game Added"
      redirect_to "/wishlist"
    else
      flash[:danger] = "Game Not Added. Error!"
      render :new
    end
  end

  def edit
  end

  def update
    @wishlist = Wishlist.find(params[:id])
    @wishlist.update(priority: params[:priority])
  end
end
