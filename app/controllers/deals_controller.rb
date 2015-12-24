class DealsController < ApplicationController

  before_action :authenticate_user!

  def new
    @deal = Deal.new
    @product_id = params[:id]
    p "test new"
    p params[:id]
    p @product_id
    p "test new end"
  end

  def create
    p "test create begin"
    p @product_id
    p "test create end"
    @deal = Deal.new(review_params)
    @product_id = params[:id]
    if @deal.save
      @deal = @deal.update(user_id: current_user.id, product_id: @product_id)
      flash[:success] = "Deal Added"
      redirect_to "/index"
    else
      flash[:danger] = "Error!"
      render :new
    end
  end



  def review_params
    params.require(:deal).permit(:price, :comment, :url, :date)
  end
end
