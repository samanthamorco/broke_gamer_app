class Api::V1::WishesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user && current_user.wishes.any?
      @wishes = current_user.wishes.all
      @wishes = @wishes.sort_by {|product| product.priority}
    end
  end

  def show
    @wish = Wish.find(params[:id])
  end

  def destroy
    id = params[:id]
    @wish = Wish.find_by(id: id)
    @wish.destroy
  end

  def new
    id = params[:id]
    @wish = Wish.new
  end

  def create
    @wish = Wish.new(product_id: params[:product_id], product_name: params[:product_name], price: params[:price], user_id: current_user.id)
    if @wish.save
    else
      render :new
    end
  end

  def edit
  end

  def update
    @wish = Wish.find(params[:id])
    @wish.update(priority: params[:priority], price: params[:price])
    render :index
  end
end
