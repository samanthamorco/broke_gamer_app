class AddDefaultPriorityToWishlist < ActiveRecord::Migration
  def change
    change_column :wishlists, :priority, :integer, default: 1

  end
end
