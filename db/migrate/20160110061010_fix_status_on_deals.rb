class FixStatusOnDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :status, :string
    add_column :deals, :status, :string

  end
end
