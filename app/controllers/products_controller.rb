class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:status] = :success
      flash[:message] = "Successfully created product: #{@product.id}"
      redirect_to products_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create product"
      flash.now[:details] = @product.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update_attributes(product_params)

    if @product.save
      redirect_to product_path(@product)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  private
  def product_params
    return params.require(:product).permit(:name, :description, :price, :stock ,:category_id, :photo_URL, :merchant_id)
  end
end
