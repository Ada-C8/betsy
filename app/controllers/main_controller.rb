class MainController < ApplicationController

  def index
    @products = Product.all
    @merchants = Merchant.all
  end

  def add_to_cart
    if session[:cart].nil?
      session[:cart] = []
    end
    session[:cart] << OrderProduct.new(quantity: params["quantity"], product_id: params["id"])
    redirect_to products_path
  end
end
