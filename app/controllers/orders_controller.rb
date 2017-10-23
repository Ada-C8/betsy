class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update]

  def index
    @orders = Order.all
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
      if @order.status == "complete"
        flash[:result_text] = "You cannot edit a complete order"
        redirect_to root_path
      end
    end
  end

  def update
    if !@order
      redirect_to root_path, status: :not_found
    elsif @order
      if @order.status == "complete"
        flash[:status] = :failure
        flash[:result_text] = "You cannot update a complete order"
        redirect_to root_path
      else @order.status = "complete"
        if @order.update_attributes order_params
          flash[:status] = :success
          flash[:result_text] = "You have successfully submitted your order!"
          session[:order_id] = nil
          redirect_to confirm_order_path(@order.id)
        else
          flash[:status] = :failure
          flash[:result_text] = "All fields are required to complete your order."
          render :edit, status: :bad_request
        end
      end
    end
  end

  private

  def order_params
    return params.require(:order).permit(:name, :address, :city, :state, :zip_code, :email, :card_number, :card_exp, :card_cvv)
  end

  def find_order
    @order = Order.find_by(id: session[:order_id])
  end

end
