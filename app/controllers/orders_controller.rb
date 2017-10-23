class OrdersController < ApplicationController
  skip_before_action :require_login, only: [:add_to_cart, :show]

  def index
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

  def show
    # will show order with all products listed and their quantity,
    # as well as the status,
    # so this info is also pulled in from the orders_products

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
    # create new instance of order and set status to "pending"
    order = Order.new
    order.status = "pending"
    order.save
    # set order_id to session[:order_id]
    session[:order_id] = order.id
    return order
  end

  def find_cart
    # finds cart by id
    @cart = Order.find_by(id:session[:order_id], status: "pending")
  end
end
