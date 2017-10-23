class Billing < ApplicationRecord
  validates :street, :city, :state, :ship_zip, :email, :credit_card, :exp, :cvv, :bill_zip, presence: true
  # all these things are required
  # apt is optional

end
