class OrdersController < ApplicationController
#TODO: clean up with controller filters
#TODO: discuss rules around destroy action.
#TODO: does it make sense to have flash messages for Order.create???
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    unless @order
      redirect_to root_path, status: :not_found
    end
  end

  #Do we actually need a new action?
  def new
    @order = Order.new
  end

  def create
    create_order
    # @order = Order.new
    # @order.status = "pending"
    #
    # if @order.save
    #   session[:order_id] = @order.id
    #   flash[:success] = "Order added successfully"
    #   redirect_to root_path
    # else
    #   flash[:error] = "Order couldn't be processed."
    #   render :new
    # end
  end

  def edit
    @order = Order.find_by(id: params[:id])

    if !@order
      redirect_to root_path, status: :not_found
    elsif @order
      if @order.status == "complete"
        flash[:error] = "You cannot edit a complete order"
        redirect_to root_path
      end
    end
  end

  def update
    @order = Order.find_by(id: params[:id])

    if !@order
      redirect_to root_path, status: :not_found
    elsif @order
      if @order.status == "complete"
        flash[:error] = "You cannot update a complete order"
        redirect_to root_path
      else
        @order.status = "complete"
        if @order.update_attributes order_params
          flash[:success] = "You successfully submitted your order!"
          redirect_to root_path
          session[:order_id] = nil
        else
          flash[:error] = "All fields are required to complete your order."
          render :edit, status: :bad_request
        end
      end
    end
  end

  private
  def order_params
    return params.require(:order).permit(:email, :address, :name, :card_number, :card_exp, :card_cvv, :zip_code)
  end

end
