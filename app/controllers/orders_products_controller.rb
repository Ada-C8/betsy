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

  def destroy_all
    #remove all products tied to a particular order number
    #change status to cancelled in orders_controller

      # order = Order.find_or_create_cart(session[:order_id]) # find or create a cart (in order.rb)
      #
      # product = Product.find_by(id: params[:id])
      # product.order_products.destroy

      order = Order.find_or_create_cart(session[:order_id])
      order_products = OrderProduct.where(id: params[:ids].split(","))
      order_products.destroy_all


      # array_orderproducts = product.order_products
      # array_orderproducts.each do |op|
      #   if op.product.id == product.id
      #     op.destroy
      #     break
      #   end
      # end
      redirect_to order_path(session[:order_id])
  end

end
