class OrdersController < ApplicationController
  skip_before_action :require_login

  def index
    # placeholder for error message (empty cart)
  end

  def add_to_cart
    order = Order.find_or_create_cart(session[:order_id]) # find or create a cart (in order.rb)
    session[:order_id] = order.id # the session's order_id will be reset to the current order.id (was either nil or existed already--"unless")
    product = Product.find_by(id: params[:id]) # find the product from the URL param
    order.products << product # (the has_many declaration creates some cool ruby magic methods like this)

    redirect_to product_path(product)
  end

  def billing_form
    # needed to show billing form view
    @billing = Billing.new
  end

  def submit
  end

  def show
    @cart = Order.find_or_create_cart(session[:order_id]) # cart instance
  end

  def submit
    @cart.subtract_product
    @cart.status = "paid"
    session[:order_id] = nil
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end
  # moved private methods to model
end
