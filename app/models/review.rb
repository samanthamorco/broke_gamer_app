class Review < ActiveRecord::Base
  # include ActiveModel::Model
  # include ActiveModel::Naming
  # include ActiveModel::Conversion

  # include ActiveModel::Associations

  belongs_to :user
  # belongs_to :product

end
