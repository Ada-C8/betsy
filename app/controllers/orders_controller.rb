class OrdersController < ApplicationController

  before_action only:[:index] do
    restrict_merchant(params[:merchant_id])
  end

  def index
    if params[:merchant_id]
      @merchant = Merchant.find_by(id: params[:merchant_id])
      @paid_orders_hash = @merchant.orders_hash_by_status("paid")
      @complete_orders_hash = @merchant.orders_hash_by_status("complete")
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    # render_404 unless @order
    unless @order
      head :not_found
    end
  end


  def create
    @order = current_order # An order already exists, use existing order
    if @order.product_ids.empty? # If the order is EMPTY
      order_item = OrderItem.new(order_items_params)
      @order.order_items << order_item
    elsif @order.product_ids.include? params[:product_id].to_i # IF THE PRODUCT IS ALREADY IN THE CART
      order_item = @order.order_items.find_by(product_id: params[:product_id])
      order_item.quantity += params[:quantity].to_i
      order_item.save
    else # FOR ALL OTHER CASES
      order_item = OrderItem.new(order_items_params)
      @order.order_items << order_item
    end

    if save_and_flash(@order)
      session[:order_id] = @order.id
    end
    redirect_to cart_path
  end

  def destroy # CANCEL
    if @order.destroy
      flash[:status] = :success
      flash[:message] = "Your order was canceled! May the force be with you!"
    else
      flash[:status] = :failure
      flash[:message] = "Whoops! Your order could not be canceled!"
      #flash[:errors] = @order.errors.messages
    end
  end

  private

  def order_items_params
    params.permit(:quantity, :product_id)
  end
end
