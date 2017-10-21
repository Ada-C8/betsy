class OrdersController < ApplicationController

  def index
  end

  def create
  end

  def add_to_cart
    if session[:order_id] == nil
      @order = start_new_order
    else
      @order = find_cart
    end
    @product = Product.find_by(id: params[:id])
    @order_product = OrderProduct.new
    @order_product.order = @order
    @order_product.product = @product
    @order_product.save

    redirect_to product_path(@product)
  end

  def create
  end

  def show
    # will show order with all products listed and their quantity, as well as the status, so this info is also pulled in from the orders_products
    @cart = find_cart

    unless @cart
      flash[:status] = :error
      # TODO :: make error message more detailed
      flash[:message] = "There was an error"
      redirect_to root_path, status: :not_found
    end
    # binding.pry
    @order_products = @cart.order_products
  end

  def show_cart
    # find_cart
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end

  private
  def start_new_order
    order = Order.new
    order.status = "pending"
    order.save
    # set order_id
    session[:order_id] = order.id
    return order
  end

  def find_cart
    @cart = Order.find_by(id:session[:order_id], status: "pending")
  end
end
