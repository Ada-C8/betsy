class RemoveNullFromBilling < ActiveRecord::Migration[5.1]
  def change
    change_column_null :billings, :street, :true
    change_column_null :billings, :city, :true
    change_column_null :billings, :state, :true
    change_column_null :billings, :ship_zip, :true
    change_column_null :billings, :email, :true
    change_column_null :billings, :credit_card, :true
    change_column_null :billings, :exp, :true
    change_column_null :billings, :cvv, :true
    change_column_null :billings, :bill_zip, :true
  end
end
