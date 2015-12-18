class AddStatusToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :status, :string

  end
end
