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
    @item = OrderItem.new(orders_params)
    # @order.order_items << @item
    # @item = @order.order_items.new(order_items_params)
    if save_and_flash(@order)
      session[:order_id] = @order.id
    end
    redirect_to cart_path
  end

  # def current_order
  #   if session[:order_id]
  #     Order.find(session[:order_id])
  #   else
  #     Order.new
  #   end
  # end





  # def update
  #   @order.update_attributes(orders_params)
    #if @order.save
      # if @order.payment_id
      #   @order.status = "paid"
      #   flash[:status] = :success
      #   flashs[:message] = "Your payment was receive. Thanks for shopping."
      #   redirect_to root_path
      # else
      #   flash[:status] = :failure
      #   flash[:message] = "Invalid payment information"
      #   flash[:erros] = @order.errors.messages
      #   redirect_to new_payment_path
      #   render "payment/show"
      # end
    # unless @order.save
    #   flash[:status] = :failure
    #   flash[:message] = "Could not update your order"
    #   flash[:errors] = @order.errors.messages
    #   redirect_to root_path
    # end


#  end


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

  def orders_params
    params.require(:order).permit(order_item_attributes:[:product_id, :quantity])
  end
end
