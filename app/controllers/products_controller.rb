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
      @savings = @product["salePrice"] - @deal.price
    end
  end

  # def search
  #   search_term = params[:search]
  #   if params[:page]
  #     page = params[:page]
  #   else
  #     page = 1
  #   end
  #   hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=abcat0700000?show=sku,image,name,shortDescription,productID,salePrice,onSale&pageSize=12&page=#{page}&format=json&apiKey=#{ENV['API_KEY']}").body
  #   @products = hash.where("name LIKE ? OR shortDescription LIKE ?", "%#{search_term}%", "%#{search_term}%")
  #   render :index 
  # end

end