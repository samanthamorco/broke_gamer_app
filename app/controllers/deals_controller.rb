class DealsController < ApplicationController

  before_action :authenticate_user!

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(review_params)
    if @deal.save
      @deal = @deal.update(user_id: current_user.id)
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
