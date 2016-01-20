class Wish < ActiveRecord::Base
  # include ActiveModel::Model
  # include ActiveModel::Naming
  # include ActiveModel::Conversion

  belongs_to :user
  belongs_to :deal
  # has_many :products

  validates :product_name, :price, presence: true
  validates :price, numericality: true

end
