class OrdersController < ApplicationController
#UNFINISHED
  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    #set session[:order_id] == order.id
    @order = Order.new order_params

    if @order.save
      session[:order_id] = order.id
      flash[:success] = "Order added successfully"
      redirect_to root_path
    else
      flash[:error] = "Order couldn't be processed."
      render :new
    end
  end

  def edit
    @order = Order.find_by(id: params[:id])

    unless @order
      redirect_to root_path
    end
  end

  def update
    @order = Order.find_by(id: params[:id])
    redirect_to orders_path unless @order

    if @order.update_attributes order_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def order_params
    return params.require(:order).permit(:status, :email, :address, :name, :card_number, :card_exp, :card_cvv, :zip_code)
  end

end
