class Order < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :order_products
  has_many :products, through: :order_products

  validates :cust_cc, :cust_cc_exp, :cust_addr, :cust_email, :status, :cust_name, presence: true
  validates_format_of :cust_email, :with =>  /\A\w+@\w+\.\w+\z/
  validate :has_order_products

  def has_order_products
    errors.add(:products, 'must have at least one product') unless order_products.count > 0
  end
end
