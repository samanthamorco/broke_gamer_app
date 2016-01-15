class Product
  # include ActiveModel::Model
  # include ActiveModel::Naming
  # include ActiveModel::Conversion
  # include ActiveModel::Associations
# has_many :deals
# has_many :reviews
# belongs_to :wishlist

attr_accessor :name, :sku, :shortDescription, :longDescription, :salePrice, :image, :manufacturer, :categoryPath, :platform, :releaseDate, :products, :id
attr_reader :product_ids

def initialize(hash)
  @name = hash["name"]
  @genre = hash["genre"]
  @id = hash["sku"]
  @shortDescription = hash["shortDescription"]
  @longDescription = hash["longDescription"]
  @salePrice = hash["salePrice"]
  @image = hash["image"]
  @manufacturer = hash["manufacturer"]
  @categoryPath = hash["categoryPath"]
  @platform = hash["platform"]
  @releaseDate = hash["releaseDate"]
  @onSale = hash["onSale"]
  @products = hash["products"]
  @total_pages = hash["totalPages"]
  # @relatedProducts.sku = hash["relatedProducts.sku"]
end

def self.all
  products = []
  products_hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=abcat0700000)?show=name,genre,sku,image,shortDescription,salePrice,onSale&pageSize=12&page=1&format=json&apiKey=#{ENV['API_KEY']}").body
  products_many = products_hash["products"]
  products_many.each do |game|
    products << Product.new(game)
  end
  return products
end

def self.system(system_type, page)
  products = []

  systems = {
    "All" => "abcat0700000", "XboxOne" => "pcmcat303600050005", "Xbox360" => "abcat0701002",
    "PS4" => "pcmcat296300050018", "PS3" => "abcat0703002", "PS2" => "abcat0704002",
    "PSVita" => "pcmcat265900050010", "PSP" => "abcat0705002",
    "WiiU" => "pcmcat274600050017", "Wii" => "abcat0706002",
    "3DS" => "pcmcat235500050004", "DS" => "abcat0707002",
    "PC" => "pcmcat174700050005"
    }

  systems.each do |system, id|
    if system_type == system
      products_hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=#{id})?show=sku,image,name,shortDescription,productID,salePrice,onSale&pageSize=12&page=#{page}&format=json&apiKey=#{ENV['API_KEY']}").body
      $total_pages = products_hash["totalPages"]
      products_many = products_hash["products"]
      products_many.each do |game|
        products << Product.new(game)
      end
      return products
    end
end

end

def self.find(id)
  product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEY']}").body
  product_initial = product_hash["products"]
  product = Product.new(product_initial.first)
end

def self.search(search_params, page)
  products = []
  products_hash = Unirest.get("http://api.bestbuy.com/v1/products((name=#{search_params}*)&categoryPath.id=abcat0700000)?show=name,genre,sku,image,shortDescription,salePrice,onSale&pageSize=50&page=#{page}&format=json&apiKey=#{ENV['API_KEYS']}").body
    products_many = products_hash["products"]
    products_many.each do |game|
        products << Product.new(game)
      end
    return products
end

def self.reviews(id)
  Review.where(product_id: id)
end

def persisted?
  false
end

end