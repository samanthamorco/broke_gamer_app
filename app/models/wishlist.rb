class Wishlist < ActiveRecord::Base
  include ActiveModel::Model
  include ActiveModel::Naming
  include ActiveModel::Conversion


  belongs_to :user
  # has_many :products


end
