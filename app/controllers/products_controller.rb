class ProductsController < ApplicationController

  def index
    systems = {PS4: "pcmcat295700050012", PS3: "abcat0703000"}
    hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=abcat0700000)?show=image,name,shortDescription,salePrice,onSale&format=json&apiKey=5rnsy6rxdnw33npjhqnj4m4q").body
    systems.each do |system, id|
      p params[:system]
      p system
      p systems[system]
      if params[:system] == system
          hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=#{id})?show=image,name,shortDescription,salePrice,onSale&format=json&apiKey=5rnsy6rxdnw33npjhqnj4m4q").body
        end
      end
    @products = hash["products"]
  end
end
