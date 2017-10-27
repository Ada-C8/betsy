class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update]
  before_action :find_merchant, only: [:index]

  def index
    if current_user != @merchant
      flash[:result_text] = "You cannot view this page"
      return redirect_to home_path
    end
    if params[:status] == "pending"
      @merch_orders = Order.joins(:products).where({ "products.merchant_id" => session[:user_id]}).select("orders.*", "products.name as product_name", "products.price as product_price", "products.id as product_id")

      @merch_orders = @merch_orders.where(:status => "pending")

    elsif params[:status] == "complete"
      @merch_orders = Order.joins(:products).where({ "products.merchant_id" => session[:user_id] }).select("orders.*", "products.name as product_name", "products.price as product_price", "products.id as product_id")

      @merch_orders = @merch_orders.where(:status => "complete")

    elsif params[:status] == "shipped"
      @merch_orders = Order.joins(:products).where({ "products.merchant_id" => session[:user_id] }).select("orders.*", "products.name as product_name", "products.price as product_price", "products.id as product_id")

      @merch_orders = @merch_orders.where(:status => "shipped")

    else
      @merch_orders = Order.joins(:products).where({ "products.merchant_id" => session[:user_id] }).select("orders.*", "products.name as product_name", "products.price as product_price", "products.id as product_id")
    end
  end

  def show
    unless @order
      redirect_to root_path, status: :not_found
    end
  end

  def new
    @order = Order.new
  end

  def create
    create_order
    #see application controller
  end

  def edit
    if !@order
      redirect_to root_path, status: :not_found
    elsif @order
      if @order.status == "shipped"
        flash[:result_text] = "You cannot edit a shipped order"
        redirect_to home_path
      end
    end
  end

  def update
    if !@order
      redirect_to root_path, status: :not_found
    elsif @order
      if @order.status == "shipped"
        flash[:status] = :failure
        flash[:result_text] = "You cannot update a shipped order"
        redirect_to home_path
      else
        @order.status = "complete"
        if @order.update_attributes order_params
          # @order.status = "complete"
          @order.save
          flash[:status] = :success
          flash[:result_text] = "You have successfully submitted your order!"
          session[:order_id] = nil
          redirect_to order_confirm_order_path(@order.id)
        else
          flash[:status] = :failure
          flash[:result_text] = "All fields are required to complete your order."
          render :edit, status: :bad_request
        end
      end
    end
  end

  def shipped
    find_order
    if @order.status == "complete"
      @order.status = "shipped"
      if @order.save
        flash[:status] = :success
        flash[:result_text] = "You have successfully shipped your order!"
        redirect_back fallback_location: root_path
      else
        flash[:status] = :failure
        flash[:result_text] = "Couldn't mark as shipped."
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Can't ship an order that is not complete"
      must_redirect_to home_path
    end
  end

  def individual_order
    find_order
  end

  private

  def order_params
    return params.require(:order).permit(:status, :name, :address, :city, :state, :zip_code, :email, :card_number, :card_exp, :card_cvv)
  end

  def find_order
    @order = Order.find_by(id: session[:order_id])
  end

  def find_merchant
    @merchant = Merchant.find_by(id: params[:merchant_id])
  end

end
