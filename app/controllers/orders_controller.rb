class OrdersController < ApplicationController
  skip_before_action :require_login

  def index
  end

  def add_to_cart
    order = Order.find_or_create_cart(session[:order_id])
    session[:order_id] = order.id
    product = Product.find_by(id: params[:id])
    order.products << product # magic ruby method

    redirect_to product_path(product)
  end

  def show
    # will show order with all products listed and their quantity,
    # as well as the status,
    # so this info is also pulled in from the orders_products

    @cart = Order.find_or_create_cart(session[:order_id])
  end

  def show_cart
    # find_cart
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end

  # moved private methods to model
end
