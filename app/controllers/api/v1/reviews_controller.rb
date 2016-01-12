class Api::V1::ReviewsController < ApplicationController

  # before_action :authenticate_user!

  
  def new
    @review = Review.new
  end

  def create
    # @review = Review.new(review_params)
    # @review = Review.new(comments: params[:comments], rating: params[:rating])
    @review = Review.new(date: Time.now, user_id: current_user.id, comments: params[:comments], rating: params[:rating], product_id: params[:product_id])
    # @review = Review.new(comments: params[:comments], rating: params[:rating], product_id: params[:product_id])
    if @review.save
      flash[:success] = "Review Added"
      render json: @reviews
      # redirect_to "/products/#{params[:product_id]}"
    else
      flash[:danger] = "Error!"
      render json: { errors: @review.errors.full_messages}, status: 422
    end
  end

  def index
    
    # @reviews = Review.where(product_id: params[:id])
    @reviews = Review.all
  end

  def show
  end




end
