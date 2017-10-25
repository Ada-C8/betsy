class OrdersController < ApplicationController
  skip_before_action :require_login

  def index
    # placeholder for error message (empty cart)
  end

  def add_to_cart
    order = Order.find_or_create_cart(session[:order_id]) # find or create a cart (in order.rb)
    session[:order_id] = order.id # the session's order_id will be reset to the current order.id (was either nil or existed already--"unless")
    product = Product.find_by(id: params[:id]) # find the product from the URL param
    result = order.products << product # (the has_many declaration creates some cool ruby magic methods like this)

    if result
      flash[:status]  = :success
      flash[:message] = "Successfully added item to cart"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to add item to cart"
      flash.now[:details] = order.products.errors.messages
    end
    redirect_to product_path(product)
  end

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
    @order = Order.find_by(id:session[:order_id], status: "pending")
    @order.subtract_product
    @order.status = "paid"

    session[:order_id] = nil

    if @order.status = "paid" && session[:order_id] = nil
      flash[:status]  = :success
      flash[:message] = "Successfully submitted your order"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed submit your order"
    end
    render :show_order
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end
  # moved private methods to model
end
