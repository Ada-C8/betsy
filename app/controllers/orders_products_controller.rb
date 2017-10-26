class OrdersProductsController < ApplicationController
  def index
  end

  def new
    # add a product (by product_id)
    #include a quantity for that product
    #tie it to a sepecif order number
  end

  def create
  end

  def edit
    #remove product IDs
  end

  def update
  end

  def destroy
    #remove all products tied to a particular order number
    #change status to cancelled in orders_controller

      # order = Order.find_or_create_cart(session[:order_id]) # find or create a cart (in order.rb)
      #
      # product = Product.find_by(id: params[:id])
      # product.order_products.destroy

      order = Order.find_or_create_cart(session[:order_id])
      product = Product.find_by(id: params[:id])
      array_orderproducts = product.order_products
      array_orderproducts.each do |op|
        if op.order.id == session[:order_id]
          op.destroy
        end
      end
  end

end
