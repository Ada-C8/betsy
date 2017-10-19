class OrdersController < ApplicationController

  def index
  end

  def new
    #will create a new Order, with a status assigned to that id
  end

  def show
    #will show order with all products listed and their quantity, as well as the status, so this info is also pulled in from the orders_products
  end

  def destroy
    #updates order to cancelled, removes all associated products from OP table
  end

end
