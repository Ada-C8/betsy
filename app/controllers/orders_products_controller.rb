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
  end

end
