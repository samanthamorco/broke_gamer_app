class WishesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user && current_user.wishes.any?
      @wishes = current_user.wishes.all
      @wishes = @wishes.sort_by {|product| product.priority}
    end
  end

  def show
    if current_user && current_user.wishes.any?
      @wish = current_user.wishes.all
      @wish = @wishes.sort_by {|product| product.priority}
    end
  end

  def destroy
    id = params[:id]
    @wish = Wish.find_by(id: id)
    @wish.destroy
    flash[:danger] = "Item Removed"
    redirect_to "/wishes"
  end

  def new
    id = params[:id]
    @wish = Wish.new
  end

  def create
    @wish = Wish.new(product_id: params[:product_id], product_name: params[:product_name], price: params[:price], user_id: current_user.id)
    if @wish.save
      flash[:success] = "Game Added"
      redirect_to "/wishes"
    else
      flash[:danger] = "Game Not Added. Error!"
      render :new
    end
  end
end