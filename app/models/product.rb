class Product

has_many :deals
has_many :reviews

# attr_accessor :name, :sku, :shortDescription, :longDescription, :salePrice, :image, :manufacturer, :categoryPath, :platform, :releaseDate, :id

# def initialize(hash)
#   @name = hash["name"]
#   @sku = hash["sku"]
#   @shortDescription = hash["shortDescription"]
#   @longDescription = hash["longDescription"]
#   @salePrice = hash["salePrice"]
#   @image = hash["image"]
#   @manufacturer = hash["manufacturer"]
#   @categoryPath = hash["categoryPath"]
#   @platform = hash["platform"]
#   @releaseDate = hash["releaseDate"]
#   @id = hash["id"]
# end

# def self.all
#   products = []
#     systems = {
#       "XboxOne" => "pcmcat303600050005", "Xbox360" => "abcat0701002",
#       "PS4" => "pcmcat296300050018", "PS3" => "abcat0703002", "PS2" => "abcat0704002",
#       "PSVita" => "pcmcat265900050010", "PSP" => "abcat0705002",
#       "WiiU" => "pcmcat274600050017", "Wii" => "abcat0706002",
#       "3DS" => "pcmcat235500050004", "DS" => "abcat0707002",
#       "PC" => "pcmcat174700050005"
#     }
#     products_hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=abcat0700000)?show=genre,sku,image,name,shortDescription,salePrice,onSale&pageSize=12&page=1&format=json&apiKey=5rnsy6rxdnw33npjhqnj4m4q").body
#     systems.each do |system, id|
#       if params[:system] == system
#         products_hash = Unirest.get("http://api.bestbuy.com/v1/products(categoryPath.id=#{id})?show=sku,image,name,shortDescription,salePrice,onSale&pageSize=12&page=1&format=json&apiKey=5rnsy6rxdnw33npjhqnj4m4q").body
#       end
#     end
#   products_hash.each do |game|
#     products << Product.new(game)
#   end
#   return products
# end





end