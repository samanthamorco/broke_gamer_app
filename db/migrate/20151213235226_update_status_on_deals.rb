class UpdateStatusOnDeals < ActiveRecord::Migration
  def change
    change_column :deals, :status, :string, default: "active"
  end
end
