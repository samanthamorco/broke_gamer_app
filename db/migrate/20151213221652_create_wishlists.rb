class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.integer :product_id
      t.string :product_name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
