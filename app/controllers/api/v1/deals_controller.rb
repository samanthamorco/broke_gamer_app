class Api::V1::DealsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, except: [:index, :new, :create]


  def show
    @deal = Deal.find_by(id: params[:id])
  end

  def index
    @deals = Deal.all
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update
    @deal = Deal.find_by(id: params[:id])
    p params[:id]
    @deal.update(status: params[:status], url: params[:url], comment: params[:comment], product_id: params[:product_id], price: params[:price])
    render :show
  end


end
