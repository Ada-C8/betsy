class MainController < ApplicationController

  def index
  end

  def add_to_cart
    if session[:cart].nil?
      session[:cart] = []
    end
    find_object_by_params(Product)
    order_product = OrderProduct.create(quantity: params["quantity"], product_id: @product.id, status: "pending")
    session[:cart] << order_product.id
    flash[:status] = :success
    flash[:message] = "#{@product.name} added to cart."
    redirect_to products_path
  end

  def shopping_cart
    session[:cart] ||= []
    @products = OrderProduct.find_in_cart(session[:cart])
  end
end
