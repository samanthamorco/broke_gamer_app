class Product

attr_accessor :name, :sku, :shortDescription, :longDescription, :salePrice, :image, :manufacturer, :categoryPath, :platform, :releaseDate

def initialize(hash)
  @name = hash["name"]
  @sku = hash["sku"]
  @shortDescription = hash["shortDescription"]
  @longDescription = hash["longDescription"]
  @salePrice = hash["salePrice"]
  @image = hash["image"]
  @manufacturer = hash["manufacturer"]
  @categoryPath = hash["categoryPath"]
  @platform = hash["platform"]
  @releaseDate = hash["releaseDate"]





end