class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  has_many :merchants, through: :products

  # class methods instead of instance methods (like in ctrl)
  # self.start_new_order is a class method
  def self.start_new_order
    order = Order.new
    order.status = "pending"
    order.save
    return order
  end

  def submit(billing_params)
    billing = Billing.new(billing_params)
    if billing.save
      self.status = "paid"
      unless self.subtract_products # if you can't subract products, we know it fails
        return false
      end
      self.products.clear
      self.save # officially changes status to "paid"
      return true
    end
    #   something.transaction
    #   2. status change from pending to paid
    #   1. subtract_products
    #   3. clear cart
    return false
  end

  # def pending_to_paid
  #   self.status = "paid"
  # end
  #
  # def clear_cart
  #
  # end

  def get_quantities
    items = {} # keys are the product, values are the quantity

    self.products.each do |product|

      if items.include?(product)
        items[product] += 1 # if the current product is in the cart, add 1 to its value
      else
        items[product] = 1 # if the current product is not in the cart, set its initial value to 1
      end
    end
    return items # hash of all items in the cart, k = product, v = quantity
  end

  # subtract_products is an instance method
  # self inside this method is calling `self` on an instance of order
  def subtract_products
    Order.transaction do
      self.get_quantities.each do |product, quantity|
        product.stock -= quantity # reduce from STOCK
        product.save
      end
    end
    return true
  rescue StandardError => e # something failed when updating the database
    puts e.message
    puts e.backtrace.inspect
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
