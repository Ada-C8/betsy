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

  def subtract_product
    Order.transaction do
      self.order_products.each do |op|
        quantity = op.quanitity
        op.product.stock -= quantity
        op.product.save!
      end


      return true #update saved to database and we are done
      # return nil # this method does not return anything, it only updates the product database.
    end
  rescue StandardError # something failed when updating the database
    return false # explicitly returning false instead of an exception
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
