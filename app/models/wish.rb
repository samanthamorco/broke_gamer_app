class Wish < ActiveRecord::Base
  # include ActiveModel::Model
  # include ActiveModel::Naming
  # include ActiveModel::Conversion


  belongs_to :user
  belongs_to :deal
  # has_many :products


end
