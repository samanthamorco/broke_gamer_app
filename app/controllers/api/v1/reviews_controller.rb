class Api::V1::ReviewsController < ApplicationController

  # before_action :authenticate_user!

  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(date: Time.now, user_id: current_user.id, comments: params[:comments], rating: params[:rating], product_id: params[:product_id])
    if @review.save
      render json: @reviews
      # redirect_to "/products/#{params[:product_id]}"
    else
      render json: { errors: @review.errors.full_messages}, status: 422
    end
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find_by(id: params[:id])
    p params[:id]
    p @review
    @review.update(upvotes: params[:upvotes])
    p @review
    render partial: '/api/v1/_reviews.json.jbuilder'
  end
end
