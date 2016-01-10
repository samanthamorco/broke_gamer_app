class UpdateRoleIdOnUser < ActiveRecord::Migration
  def change
    change_column :users, :role_id, :integer, default: 2

  end
end
