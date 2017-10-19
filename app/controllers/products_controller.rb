class ProductsController < ApplicationController
  before_action :find_product_by_params, only: [:show, :edit, :update, :destroy]

  before_action :confirm_login, only: [:new, :create, :edit, :update, :destroy]

  before_action :confirm_ownership, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def find_product_by_params
    @product = Product.find(params[:id])

    unless @product
      return head :not_found
    end
  end

  def confirm_login
    if session[:user_id].nil?
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that."
      return redirect_back(fallback_location: products_path)
    end
  end

  def confirm_ownership
    unless session[:user_id] == @product.merchant_id
      flash[:status] = :failure
      flash[:message] = "Only a product's merchant can modify a product."
      return redirect_back(fallback_location: products_path)
    end
  end
end
