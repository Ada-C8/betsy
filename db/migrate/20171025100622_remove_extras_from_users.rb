class RemoveExtrasFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :mailing_address,  :string
    remove_column :users, :cc_number, :string
    remove_column :users, :cc_expiration_date, :date
    remove_column :users, :cc_cvv, :integer
    remove_column :users, :zipcode, :string
  end
end
