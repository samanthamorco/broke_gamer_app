class ReviewsController < ApplicationController
  before_action :authenticate_user!

  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      @review = @review.update(date: Time.now, user_id: current_user.id)

      flash[:success] = "Review Added"
      redirect_to "/index"
    else
      flash[:danger] = "Error!"
      render :new
    end
  end



  def review_params
    params.require(:review).permit(:rating, :comments)
  end

end

