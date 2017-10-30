class AddMerchantColumn < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :merchant_status, :boolean)
  end
end
