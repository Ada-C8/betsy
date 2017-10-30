class AddUseridToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :user_id, :bigint
  end
end
