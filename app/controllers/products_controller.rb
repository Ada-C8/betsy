class ProductsController < ApplicationController
  # before_action :fakey_login # take this out later pleeeasseee

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
    @product = Product.new(prod_params)
    @product.merchant_id = session[:user_id]

    result = @product.save

    if result
      flash.now[:status] = :success
      flash.now[:message] = "Successfully created #{@product.name}"
      return redirect_to product_path(@product.id)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not create new product"
      flash.now[:details] = @product.errors.messages
      return render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    result = @product.update(prod_params)

    if result
      flash.now[:status] = :success
      flash.now[:message] = "Successfully updated #{@product.name}"
      return redirect_to product_path(@product.id)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not update product"
      flash.now[:details] = @product.errors.messages
      return render :edit, status: :bad_request
    end
  end

  def destroy
    result = @product.destroy

    if result
      flash.now[:status] = :success
      flash.now[:message] = "Successfully deleted #{@product.name}"
      return redirect_to products_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not delete product"
      flash.now[:details] = @product.errors.messages
      return redirect_back(fallback_location: products_path)
    end
  end

  private

  def fakey_login
    session[:user_id] = Merchant.first.id
  end

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

  def prod_params
    params.require(:product).permit(:name, :image_url, :price, :quantity, :description)
  end
end
