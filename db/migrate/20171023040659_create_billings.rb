class CreateBillings < ActiveRecord::Migration[5.1]
  def change
    create_table :billings do |t|
      t.string :street, null: false
      t.string :apt
      t.string :city, null: false
      t.string :state, null: false
      t.integer :ship_zip, null: false, length: 5

      t.string :email, null: false
      t.integer :credit_card, null: false, length: 16
      t.integer :exp, null: false, length: 4
      t.integer :cvv, null: false
      t.integer :bill_zip, null: false, length: 5

      t.timestamps
    end
  end
end
