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

  # def submit
  #   something.transaction
  #   1. subtract_product
  #   2. status change from pending to paid
  #   3. clear cart
  #
  # end

  # def pending_to_paid
  #   self.status = "paid"
  # end
  #
  # def clear_cart
  #
  # end

  def get_quantities
    items = {}

    self.order_products.each do | item |
      if items.include?(item.product)
        items[item.product] += 1
      else
        items[item.product] = 1
      end
    end
    return items
  end

  def quantity_of(product)
    quantity = 0
    self.order_products.each do |op|
      if op.product_id == product.id
        quantity += 1
      end
    end
    return quantity
  end


  # subtract_product is an instance method
  # self inside this method is calling `self` on an instance of order
  def subtract_product
    Order.transaction do
      # self is redundant but does not break anything
      self.order_products.each do |op|
        quantity = op.quantity
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
