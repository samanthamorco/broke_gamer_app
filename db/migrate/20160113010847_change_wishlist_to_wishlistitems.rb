class ChangeWishlistToWishlistitems < ActiveRecord::Migration
  def change
    rename_table :wishlists, :wishlistitems
  end
end
