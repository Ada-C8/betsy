class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(name: params[:product][:name], price: params[:product][:price], quantity_avail: params[:product][:quantity_avail], merchant: params[:product][:merchant] )
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created your product!"
      redirect_to product_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@category.name} category."
      flash[:messages] = @product.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      redirect_to root_path, status: :not_found
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    if !@product
      redirect_to root_path, status: :not_found
    elsif @product.destroy
      flash[:status] = :success
      flash[:result_text] = "Product deleted"
      redirect_to products_path
    else
      flash[:status] = :failure
      flash[:result_text] = "That product is unable to be deleted."
      redirect_to products_path, status: :not_found

    end
  end

end
