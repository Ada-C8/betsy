class OrdersController < ApplicationController

  before_action :confirm_login, except: [:new, :create, :confirmation]

  def index
    # show only the orders that belong to the merchant
    if session[:merchant]
      merchant_id = session[:merchant]['id']
      @orders = Merchant.find(merchant_id).orders
    end
  end

  def new
    # new order, either with no merchant_id or with the logged-in-user's merchant_id
    @order = Order.new
  end

  def create
    # create new order, either with no merchant_id or with the logged-in-user's merchant_id
    @order = Order.new(order_params)
    @order.order_products += OrderProduct.find_in_cart(session[:cart])

    if @order.save && @order.order_products.length > 0
      @order.decrement_products
      session[:cart] = nil
      flash[:status] = :success
      flash[:message] = "Successfully created order"
      redirect_to confirmation_path(@order)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create order"
      flash.now[:details] = @order.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    # show the order if it belongs to the merchant (buyer)
    find_order_by_params_id
  end

  def edit
    # edit the order if it belongs to the merchant (buyer)
    find_order_by_params_id
    confirm_object_ownership(@order, @order.merchant_id)
  end

  def update
    # edit the desired order if it belongs to the merchant (buyer)
    if find_order_by_params_id
      @order.update_attributes(order_params)
      if @order.save
        flash[:status] = :success
        flash[:message] = "Successfully updated order"
        redirect_to order_path(@order)
        return
      else
        flash.now[:status] = :failure
        flash.now[:message] = "Order could not be updated"
        flash.now[:details] = @order.errors.messages
        render :edit, status: :bad_request
        return
      end
    end
  end

  def confirmation
    if session['merchant']
      find_order_by_params_id
      confirm_object_ownership(@order, @order.merchant_id)
    else
      return redirect_to products_path 
    end
  end

  def cancel
    find_order_by_params_id
    if @order
      if @order.order_products.any? {
        |op| op.status == "shipped"
      }
        flash[:status] = :failure
        flash[:message] = "Cannot cancel an order if one of the products has been shipped"
        render :show, status: :bad_request
      else
        @order.increment_products
        @order.status = "cancelled"
        @order.save
        flash[:status] = :success
        flash[:message] = "Successfully cancelled the order"
        redirect_to order_path(@order)
      end
    else
      return head :not_found
    end
  end

  private

  def order_params
    # parameters for the order
    return params.require(:order).permit(:cust_name, :status, :cust_email, :cust_cc, :cust_cc_exp, :cust_addr, :merchant_id, :order_products, :cvv, :zip_code)
  end

  def find_order_by_params_id
    # find the order by the id parameter
    @order = Order.find_by(id: params[:id])
    unless @order
      head :not_found
    end
    return @order
  end
end
