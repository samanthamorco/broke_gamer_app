class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.decimal :price, precision: 8, scale: 2
      t.string :url
      t.string :date
      t.text :comment
      t.integer :user_id

      t.timestamps null: true
    end
  end
end
