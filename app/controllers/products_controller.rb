class ProductsController < ApplicationController
  before_action :find_product_by_params, only: [:show, :edit, :update, :destroy]

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
end
