class RemoveCartIdAssociationOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :cart_id
  end
end
