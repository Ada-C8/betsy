class RemoveUseridFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :user_id, :string

  end
end
