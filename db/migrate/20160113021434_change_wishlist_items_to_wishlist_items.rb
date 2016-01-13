class ChangeWishlistItemsToWishlistItems < ActiveRecord::Migration
  def self.up
    rename_table :wishlistitems, :wishes
  end

  def self.down
    rename_table :wishes, :wishlistitems
  end
end
