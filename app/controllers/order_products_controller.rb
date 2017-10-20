class OrderProductsController < ApplicationController
  def index
    @order_products = OrderProduct.all
  end

  def new
    @order_product = OrderProduct.new
  end

  def create
    @order_product = OrderProduct.new(order_product_params)
    if @order_product.save
      flash[:status] = :success
      flash[:message] = "Successfully created order product #{@order_product.id}"
      redirect_to order_product_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create order product"
      flash.now[:details] = @order_product.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    find_order_product_by_params_id
  end

  def edit
    find_order_product_by_params_id
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
      flash[:message] = "Deleted order product #{@order_product.title}"
      redirect_to order_products_path
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
