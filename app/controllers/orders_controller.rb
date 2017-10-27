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
    # order.save
    if result
      # order.order_products.sum(:quantity)
      flash[:status]  = :success
      flash[:message] = "Successfully added item to cart"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to add item to cart"
      flash.now[:details] = order.products.errors.messages
    end
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
    @order = Order.find_by(id:session[:order_id], status: "pending")
  end

  def submit
    @order = Order.find_by(id:session[:order_id], status: "pending")

    if @order.submit(billing_params)
      session[:order_id] = nil # clear the session id
    end
    
    redirect_to root_path
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end

  private
  def billing_params
    return params.require(:billing).permit(:street, :apt, :city, :state ,:ship_zip, :email, :credit_card, :exp, :cvv, :bill_zip, :name)
  end
end
