class Billing < ApplicationRecord
  validates :name, :street, :city, :state, :email, :cvv, presence: true
  validates :ship_zip, :bill_zip, presence: true, length: { is: 5}
  validates :credit_card, presence: true, length: { is: 16 }
  # all these things are required
  # apt is optional

end
