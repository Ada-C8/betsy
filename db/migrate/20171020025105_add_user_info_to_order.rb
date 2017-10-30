class AddUserInfoToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :customer_name, :string
    add_column :orders, :email, :string
    add_column :orders, :mailing_address, :string
    add_column :orders, :cc_number, :string
    add_column :orders, :cc_expiration_date, :string
    add_column :orders, :cc_cvv, :string
    add_column :orders, :zipcode, :string
  end
end
