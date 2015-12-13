class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :date
      t.integer :rating
      t.text :comments
      t.integer :user_id

      t.timestamps null: true
    end
  end
end
