class AddPriorityToWishlist < ActiveRecord::Migration
  def change
    add_column :wishlists, :priority, :integer

  end
end
