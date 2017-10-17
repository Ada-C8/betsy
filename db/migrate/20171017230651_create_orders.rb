class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :cust_name
      t.string :status
      t.string :cust_email
      t.string :cust_cc
      t.string :cust_cc_exp
      t.string :cust_addr

      t.timestamps
    end
  end
end
