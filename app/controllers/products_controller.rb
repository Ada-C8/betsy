class ProductsController < ApplicationController
  def index
    if params[:merchant_id]
      merchant = Merchant.find_by(id: params[:merchant_id])
      @products = merchant.products
    elsif
      params[:review_id]
      @products = Review.where(product_id: params[:category_id])
    elsif
      params[:category_id]
      category = Category.find_by(id: params[:category_id])
      @products = category.products
      # @products = Product.includes(:categories).where(categories: { id: params[:category_id]})
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created your product!"
      redirect_to product_path(@product.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@product.name}."
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

  def add_product_to_cart
    @product = Product.find_by(id: params[:id])
    if @product.remove_one_from_stock
      if Order.find_by(id: session[:order_id]) == nil
        create_order
        order = Order.find_by(id: session[:order_id])
        order.products << @product
        order.save
        flash[:success] = "product added to cart"
        #this redirects, which causes double redirect error
      else
        order = Order.find_by(id: session[:order_id])
        order.products << @product
        order.save
        flash[:success] = "product added to cart"
        redirect_to order_path(session[:order_id])
      end
    else
      flash[:error] = "product not available"
      redirect_to products_path, status: :bad_request
    end
  end


  def remove_product_from_cart
    @product = Product.find_by(id: params[:id])

  if !@product
    flash[:status] = :failure
    flash[:result_text] = "That product isn't even in your cart."
    redirect_to products_path, status: :bad_request
  end

    order = Order.find_by(id: session[:order_id])

    index_of_first_found = order.products.index {|element| element.id == @product.id}

    orders_products_array = order.products.to_a

    orders_products_array.delete_at(index_of_first_found)

    order.products.replace([])
    order.products.replace(orders_products_array)

    @product.add_one_to_stock
    flash[:status] = :success
    flash[:result_text] = "Product successfully removed from your cart!"

    redirect_to products_path

  end

  def product_params
    params.require(:product).permit(:name, :quantity_avail, )
  end
end

private
  def product_params
    params.require(:product).permit(:name, :price, :quantity_avail, :merchant_id)
  end
