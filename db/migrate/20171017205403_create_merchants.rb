class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
