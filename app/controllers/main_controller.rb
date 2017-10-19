class MainController < ApplicationController

  def index
    @products = Product.all
    @merchants = Merchant.all
  end

end
