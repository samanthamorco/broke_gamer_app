class Review < ActiveRecord::Base
  include ActiveModel::Model
  include ActiveModel::Naming
  include ActiveModel::Conversion

  # include ActiveModel::Associations

  belongs_to :user
  # belongs_to :product

  def Product
    Product.find(product_id)
  end

end
