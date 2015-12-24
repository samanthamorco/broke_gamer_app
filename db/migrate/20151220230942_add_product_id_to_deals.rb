class AddProductIdToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :product_id, :integer
    add_column :reviews, :product_id, :integer

  end
end
