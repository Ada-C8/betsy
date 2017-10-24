class ChangeCreditCardFormatToSting < ActiveRecord::Migration[5.1]
  def change
    change_column :billings, :credit_card, :string
  end
end
