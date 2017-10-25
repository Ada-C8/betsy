class OrderItemsController < ApplicationController
  before_action only:[:ship] do
    @order_item = OrderItem.find_by(id: params[:id])
    restrict_merchant(@order_item.merchant.id)
  end

  # TODO: DO WE NEED THIS ORDERITEM?????
  def new
    @order_item = OrderItem.new
  end

  def create
    # Create a new order if there is session[:order_id]
    @order = current_order
    #TODO: This is the old code prior to order_item testing

    # @item = @order.order_items.new(order_items_params)
    # @order.save
    # session[:order_id] = @order.id
    # redirect_to merchant_orders_path
    @item = OrderItem.new(order_items_params)
    @order.order_items << @item
    # @item = @order.order_items.new(order_items_params)
    if save_and_flash(@order)
      session[:order_id] = @order.id
    end
    redirect_to cart_path
  end

  def update
    @order_item = OrderItem.find_by(id: params[:id])
    @order_item.update_attributes(order_items_params)
    # order_item can only update the quantity in th cart_controller show
    if @order_item.save
      flash[:status] = :success
      flash[:message] = "The quantity for #{@order_item.product.name} was updated!"
    else
      flash[:status] = :failure
      flash[:message] = "Unable to change quantity. Please try again."
    end
    redirect_to cart_path
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.destroy
    @order.save

    redirect_to cart_path
  end

  def ship
    @order_item.shipped = true
    @order_item.save
    @order_item.order.change_to_shipped
    @order_item.order.save
    flash[:status] = "success"
    flash[:message] = "Item Shipped"
    redirect_back fallback_location: merchant_orders_path(:merchant_id)
    #redirect_back is going to go first to request.referrer
  end
    #@order_item.update_attributes(order_items_params)


private

  def order_items_params
    params.require(:order_item).permit(:product_id, :quantity)
  end


end
