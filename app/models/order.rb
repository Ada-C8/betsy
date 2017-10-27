class Order < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :order_products
  has_many :products, through: :order_products

  validates :cust_cc, :cust_cc_exp, :cust_addr, :cust_email, :status, :cust_name, :cvv, :zip_code, presence: true
  validate :quantity_check
  validates_format_of :cust_email, :with =>  /\A\w+@\w+\.\w+\z/

  def total
    total = 0
    order_products.each do |order_product|
      total += order_product.total
    end
    return total
  end

  def quantity_check
    order_products.each do |order_product|
      available = order_product.product.quantity
      desired = order_product.quantity
      if desired > available
        errors.add("#{order_product.product.name} does not have enough stock")
      end
    end
  end

  def decrement_products
    order_products.each do |order_product|
      quantity = order_product.quantity
      product = Product.find(order_product.product_id)
      product.quantity -= quantity
      product.save
    end
  end

  def increment_products
    order_products.each do |order_product|
      quantity = order_product.quantity
      product = Product.find(order_product.product_id)
      product.quantity += quantity
      product.save
    end
  end

  def order_status
    result = order_products.all? do |order_product|
      order_product.status == "shipped"
    end
    self.status = "complete" if result
    self.save
  end
end
