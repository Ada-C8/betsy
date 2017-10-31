class AddMerchantIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :merchant_id, :integer
  end
end
