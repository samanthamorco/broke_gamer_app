class Deal < ActiveRecord::Base
  # include Her::Model
  # include ActiveModel::Model
  # include ActiveModel::Naming
  # include ActiveModel::Conversion
  # include ActiveModel::Associations

  belongs_to :user
  has_many :wishlistitems
  # belongs_to :product

  def self.sort(param)
    if param == "newest"
      deals = Deal.where(status: "active").order('created_at DESC')
    elsif param == "lowtohigh"
      p "Low to high!"
      deals = Deal.where(status: "active").order('price ASC')
    elsif param == "hightolow"
      deals = Deal.where(status: "active").order('price DESC')
    elsif param == "oldest"
      deals = Deal.where(status: "active").order('created_at ASC')
    end
    return deals
  end

  def self.total_pages(deals)
    total_pages = (deals.length / 9)
    if (deals.length % 9) > 0
      total_pages += 1
    end
    return total_pages
  end
  
  def self.total_products(deals, page)
    @products = []
    @prices = []
    if ((deals.length / page.to_i) - 9) < 1
      i = (deals.length / page.to_i).to_i
    else
      i = 9
    end

    
    count = 0
    i.times do
      deal = deals[(9 * (page.to_i - 1) + count)]
      if deal == nil
        break
      else
        @prices << deal.price
        if count % 2 == 1
          product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEYS']}").body
        else
          product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEY']}").body
        end
          count += 1
          product_initial = product_hash["products"].first
          # p product_hash["products"]
          product = Product.new(product_initial)
          @products << product
        end
      end

      return [@products, @prices]
    end


end
