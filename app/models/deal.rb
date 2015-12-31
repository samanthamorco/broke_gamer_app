class Deal < ActiveRecord::Base
  # include Her::Model

  belongs_to :user
  belongs_to :product
end
