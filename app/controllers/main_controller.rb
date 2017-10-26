class MainController < ApplicationController

  before_action only: [:add_to_cart] do
    find_object_by_params(Product)
  end

  def index
  end

  def add_to_cart
    order_product = OrderProduct.create(quantity: params["quantity"], product_id: @product.id, status: "pending")
    if order_product.valid?
      session[:cart] << order_product.id
      flash[:status] = :success
      flash[:message] = "#{@product.name} added to cart."
      redirect_to products_path
    else
      flash[:status] = :failure
      flash[:message] = "#{@product.name} could not be added to cart."
      redirect_to products_path
    end
  end

  def shopping_cart
    @products = OrderProduct.find_in_cart(session[:cart])
  end
end
