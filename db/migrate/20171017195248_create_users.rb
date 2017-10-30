class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mailing_address
      t.string :cc_number
      t.date :cc_expiration_date
      t.integer :cc_cvv
      t.string :zipcode

      t.timestamps
    end
  end
end
