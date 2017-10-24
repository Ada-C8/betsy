class Order < ApplicationRecord

  has_many :products, through: :order_items

  validates :status, presence: true
  # :customer_name, :customer_email, :customer_address,
  # :cc_number,:cc_expiration, :cc_ccv,
  # :zip_code, presence: true

end
