class PagesController < ApplicationController

  def index
    @products = []
    @deals = Deal.where(status: "active")
    count = 1
    @deals.first(8).each do |deal|
      if count % 2 == 1
        product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEYS']}").body
      else
        product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEY']}").body

      end
      count += 1
      product_initial = product_hash["products"].first
      p product_hash["products"]
      product = Product.new(product_initial)
      @products << product
    end
  end



end
