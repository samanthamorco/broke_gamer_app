class DealsController < ApplicationController

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(review_params)
    if @deal.save
      @deal = @deal.update(date: Time.now)
      flash[:success] = "deal Added"
      redirect_to "/index"
    else
      flash[:danger] = "Error!"
      render :new
    end
  end



  def review_params
    params.require(:deal).permit(:price, :comment, :url)
  end
end
