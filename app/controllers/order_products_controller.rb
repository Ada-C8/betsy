class OrderProductsController < ApplicationController
  def index
    if session[:merchant]
      @order_products = Merchant.find(params[:merchant_id]).order_products
    end
  end

  def update
    if find_order_product_by_params_id
      @order_product.update_attributes(order_product_params)
      if @order_product.save
        redirect_to order_product_path(@order_product)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    if find_order_product_by_params_id
      @order_product.destroy
      flash[:status] = :success
      flash[:message] = "Deleted order product #{@order_product.product.name}"
      redirect_to  merchant_sold_index_path(@order_product.product.merchant)
    end
  end

  private

  def order_product_params
    return params.require(:order_product).permit(:quantity, :status, :product_id, :order_id)
  end

  def find_order_product_by_params_id
    @order_product = OrderProduct.find_by(id: params[:id])
    unless @order_product
      head :not_found
    end
    return @order_product
  end
end
