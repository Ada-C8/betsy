class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  def self.start_new_order
    # create new instance of order and set status to "pending"
    order = Order.new
    order.status = "pending"
    order.save
    return order
  end

  def self.find_or_create_cart(order_id)
    order = Order.find_by(id: order_id, status: "pending") # rails won't blow up if the session id is nil, turns out
    unless order
      order = start_new_order
    end
    return order
  end
end
