class ChangeExpirationDataType < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :card_exp
    add_column :orders, :card_exp, :date
  end
end
