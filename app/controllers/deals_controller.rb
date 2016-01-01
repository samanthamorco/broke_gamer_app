class DealsController < ApplicationController

  before_action :authenticate_user!

  def new
    if params[:id]
      @deal = Deal.new
    else
      flash[:danger] = "Please select a product!"
      redirect_to "/"
    end  end

  def create
    # @deal = Deal.new(deal_params)
    @deal = Deal.new(product_id: params[:product_id], price: params[:price], url: params[:url], comment: params[:comments])    
    if @deal.save
      # @deal = @deal.update(user_id: current_user.id, product_id: @product_id)
      flash[:success] = "Deal Added"
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:danger] = "Error!"
      render :new
    end
  end



  # def deals_params
  #   params.require(:deal).permit(:price, :comment, :url, :date)
  # end
end
