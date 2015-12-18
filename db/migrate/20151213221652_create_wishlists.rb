class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.integer :product_id
      t.string :product_name
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: true
    end
  end
end
