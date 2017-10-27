class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def create_order
    @order = Order.new
    @order.status = "pending"

    if @order.save
      session[:order_id] = @order.id
      flash[:status] = :success
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not initialize pending order."
    end
  end
end
