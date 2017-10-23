class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

# class methods instead of instance methods (like in ctrl)
  def self.start_new_order
    order = Order.new
    order.status = "pending"
    order.save
    return order
  end

  # order_id being passed in is session[:order_id] from order ctrl, cannot use sessions in model methods
  ## this method can be used with any other parameter passed in, this is just the current use!
  def self.find_or_create_cart(order_id)
    order = Order.find_by(id: order_id, status: "pending") # rails won't blow up if the session id is nil, turns out
    # checking if the order has BOTH the same order_id and status "pending"
    unless order
      order = start_new_order # if no matching orders, start a new order 
    end
    return order
  end
end
