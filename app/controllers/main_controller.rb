class MainController < ApplicationController

  def index
    @products = Product.all
    @merchants = Merchant.all
  end

  def add_to_cart
    if session[:cart].nil?
      session[:cart] = []
    end
    order_product = OrderProduct.create(quantity: params["quantity"], product_id: params["id"])
    session[:cart] << order_product.id
    redirect_to products_path
  end

  def shopping_cart
    session[:cart] ||= []
    @products = OrderProduct.find_in_cart(session[:cart])
  end
end
