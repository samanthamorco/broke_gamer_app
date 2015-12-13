class ChangeDateAttributeInReview < ActiveRecord::Migration
  def change
    change_column :reviews, :date, :datetime
    change_column :deals, :date, :datetime
  end
end
