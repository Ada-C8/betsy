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

  # def remove_from_cart
  #   # order = Order.find_or_create_cart(session[:order_id]) # find or create a cart (in order.rb)
  #
  #   product = Product.find_by(id: params[:id])
  #   arrary_orderproducts = product.order_products
  #   arrary_orderproducts.each do |op|
  #     if op.order.id == session[:order_id]
  #       op.destroy
  #     end
  #   end
  # end

  def show
    # will show order with all products listed and their quantity,
    # as well as the status,
    # so this info is also pulled in from the orders_products
    @cart = Order.find_or_create_cart(session[:order_id]) # cart instance
  end

  def billing_form
    # needed to show billing form view
    @billing = Billing.new
  end

  def submit
    @cart.subtract_product
    @cart.status = "paid"
    # this is currently broken
    # TODO: figure out the current id to pass into show_order_path
    render show_order_path(@cart.id)
    session[:order_id] = nil
    redirect_to show_order_path
  end

  def billing_form
    # needed to show billing form view
    @billing = Billing.new
  end

  def submit
    @order = Order.find_by(id:session[:order_id], status: "pending")
    @order.subtract_product
    @order.status = "paid"
    render :show_order
    session[:order_id] = nil
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end
  # moved private methods to model
end
