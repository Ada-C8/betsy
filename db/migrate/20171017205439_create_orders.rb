class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :email
      t.string :address
      t.string :name
      t.string :card_number
      t.string :card_exp
      t.string :card_cvv
      t.string :zip_code
      t.timestamps
    end
  end
end
