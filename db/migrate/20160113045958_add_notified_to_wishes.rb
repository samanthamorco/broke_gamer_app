class AddNotifiedToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :notified, :boolean
  end
end
