class OrderItemsController < ApplicationController

  def new
    # try to get order out of session and if not there create one and put it in the session
    @order_item = OrderItem.new
    @product = Product.find_by(id: params[:product_id])

  end

  def create
    # if session[:order_id] == nil
    #   @order = Order.new
    #   @order.save
    #   session[:order_id] = @order.id
    # else
    #   @order = Order.find_by(id: session[:order_id])
    # end
    @product = Product.find_by(id: params[:product_id])
    @order_item = OrderItem.new(order_item_params)
    @order_item.product_id = @product.id
    @order_item.order_id = @order.id

    # @order = current_order
    if @order_item.save
      status = :success
      flash[:result_text] = "#{@order_item.quantity} #{@order_item.product.name} have been added o your order!"
      redirect_to products_path
    else
      status = :bad_request
      flash[:result_text] = "Error - products not added to your order"
      render :new, status: status
    end
    # session[:order_id] = @order.id
  end

  def edit
    @order_item = OrderItem.find_by(id: params[:id])
    @product = @order_item.product
  end

  def update
    @order_item = OrderItem.find_by(id: params[:id])
    @order = @order_item.order
    @product = @order_item.product

    unless @order.status == "incomplete"
      flash[:status] = :failure
      flash[:result_text] = "Your order cannot be edited as its status is already paid."
      redirect_to root_path
      return #need to refactor, this may break
    end

    if order_item_params[:quantity].to_i > @product.quantity
      flash[:status] = :failure
      flash[:result_text] = "Error: You must choose a quantity less than or equal to the available quantity (#{@product.quantity})"
      render :edit, status: :bad_request
    else
      @order_item.update_attributes(order_item_params)
      if @order_item.save
        flash[:status] = :success
        flash[:result_text] = "Order Item has updated."
        redirect_to order_path(@order.id)
      else
        flash[:status] = :failure
        flash[:result_text] = "Error: Could not update your order_item"
        flash[:messages] = @order_item.errors.messages
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    @order_item = OrderItem.find_by(id: params[:id])
    @order = @order_item.order

    if @order.status == "incomplete"
      @order_item.destroy
      flash[:status] = :success
      flash[:result_text] = "Order Item has been removed from cart."
    else
      flash[:status] = :failure
      flash[:result_text] = "Error: Could not update your order_item.}"
      flash[:messages] = @order.errors.messages
    end

    redirect_to order_path(@order.id)
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
