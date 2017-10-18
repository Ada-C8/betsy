class RemoveMerchantIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :merchant_id
  end
end
