class Order < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :order_products
  has_many :products, through: :order_products

  validates :cust_cc, :cust_cc_exp, :cust_addr, :cust_email, :status, :cust_name, presence: true
  validates_format_of :cust_email, :with =>  /\A\w+@\w+\.\w+\z/

  def total
    total = 0
    order_products.each do |order_product|
      total += order_product.total
    end
    return total
  end
end
