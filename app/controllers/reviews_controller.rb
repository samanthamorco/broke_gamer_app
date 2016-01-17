class ReviewsController < ApplicationController
  before_action :authenticate_user!

  
  def new
    if params[:id]
      @review = Review.new
    else
      flash[:danger] = "Please select a product!"
      redirect_to "/"
    end
  end

  def create
    # @review = Review.new(review_params)
    @review = Review.new(date: Time.now, user_id: current_user.id, comments: params[:comments], rating: params[:rating], product_id: params[:product_id])
  end



  # def review_params
  #   params.require(:review).permit(:rating, :comments)
  # end

end

