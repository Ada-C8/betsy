class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:status] = :success
      flash[:message] = "Successfully created order #{@order.id}"
      redirect_to order_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create order"
      flash.now[:details] = @order.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    find_order_by_params_id
  end

  def edit
    find_order_by_params_id
  end

  def update
    if find_order_by_params_id
      @order.update_attributes(order_params)
      if @order.save
        redirect_to order_path(@order)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    if find_order_by_params_id
      @order.destroy
      flash[:status] = :success
      flash[:message] = "Deleted order #{@order.title}"
      redirect_to order_path
    end
  end

  private

  def order_params
    return params.require(:order).permit(:cust_name, :status, :cust_email, :cust_cc, :cust_cc_exp, :cust_addr, :merchant_id)
  end

  def find_order_by_params_id
    @order = Order.find_by(id: params[:id])
    unless @order
      head :not_found
    end
    return @order
  end
end
