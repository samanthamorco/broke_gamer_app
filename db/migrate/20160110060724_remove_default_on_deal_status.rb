class RemoveDefaultOnDealStatus < ActiveRecord::Migration
  def change
    change_column :deals, :status, :string

  end
end
