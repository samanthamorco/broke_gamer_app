class ProductsController < ApplicationController

  def index 
    @products = Product.all
    if params[:system]
      if params[:page]
        page = params[:page]
      else
        page = 1
      end
      @products = Product.system(params[:system], page)
      @system = params[:system]
    end

  end

  def show
    id = params[:id]
    @product = Product.find(id)
    @reviews = Review.where(product_id: id)
    deals = Deal.where(product_id: id, status: "active")
    if deals.empty? == true
      @deal = false
    else
      @deal = deals.order('price ASC').first
      @savings = @product.salePrice - @deal.price
    end
  end

  def search
    if params[:page]
      page = params[:page]
    else
      page = 1
    end
    @products = Product.search(params[:search], page)
    render :index
  end

end