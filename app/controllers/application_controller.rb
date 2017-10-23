class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def create_order
    @order = Order.new
    @order.status = "pending"

    if @order.save
      session[:order_id] = @order.id
      flash[:success] = "Successfully created pending order."
      redirect_to order_path(@order.id)
    else
      flash[:error] = "Could not initialize pending order."
    end
  end
end
