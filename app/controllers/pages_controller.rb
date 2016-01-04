class PagesController < ApplicationController

  def index
    @products = []
    @deals = Deal.all
    @deals.first(8).each do |deal|
      product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEY']}").body
      product_initial = product_hash["products"]
      p "initial"
      p product_initial
      p "end"
      product = Product.new(product_initial.first)
      @products << product
    end
  end



end
