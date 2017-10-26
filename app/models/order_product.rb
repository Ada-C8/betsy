class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def total
    return product.price * quantity
  end

  def self.find_in_cart(cart)
    OrderProduct.all.find_all { |order_product| cart.include? order_product.id } unless cart.nil?
  end

  def check_quantity
    if product.quantity < quantity
      return false
    else
      return true
    end
  end
end
