class Deal < ActiveRecord::Base

  belongs_to :user
  has_many :wishlistitems
  # belongs_to :product
  validates :product_id, :price, :url, :date, presence: true
  validates :price, numericality: true

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
    #the code would break if there weren't 9 items on a page to view, so this code helps with that.
    if ((deals.length / page.to_i) - 9) < 1
      i = (deals.length / page.to_i).to_i
    else
      i = 9
    end

    
    # This weird code is due to Best Buy's limitation on their API. You can only make 5 calls per second, so I used a second API key to display more than 5 deals per page.
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
