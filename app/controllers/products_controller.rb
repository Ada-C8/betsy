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
<<<<<<< HEAD
      flash.now[:details] = @product.errors..messages
=======
      flash.now[:details] = @product.errors.messages
>>>>>>> b0cefe5ea8764eab1d76dd093fca2ad765cb181a
      render :new, status: :bad_request
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
<<<<<<< HEAD
    unless @product
      head :not_found
    end
=======
>>>>>>> b0cefe5ea8764eab1d76dd093fca2ad765cb181a
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def product_params
<<<<<<< HEAD
    return params.require(:product).permit(:name, :description, :price, :stock ,:category_id)
=======
    return params.require(:product).permit(:name, :description, :price, :stock ,:category_id, :photo_URL, :merchant_id)
>>>>>>> b0cefe5ea8764eab1d76dd093fca2ad765cb181a
  end
end
