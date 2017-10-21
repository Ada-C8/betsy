class ProductsController < ApplicationController

  before_action :find_product_by_params, only: [:show, :edit, :update, :destroy, :categories]

  before_action :confirm_login, except: [:index, :show]

  before_action :confirm_ownership, only: [:edit, :update, :destroy]


  def index
    if params[:category_id]
      cat = Category.find(params[:category_id])
      @products = Product.all.find_all { |prod| prod.categories.include? cat }
      @title = cat.name.capitalize
    else
      @products = Product.all.sort_by { |prod| -prod.orders.count }[0...6]
      @title = "Popular Now"
    end
    @categories = Category.all
  end

  def show
    if session[:merchant]
      @own_product = session[:merchant]['id'] == @product.merchant_id ? true : false
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(prod_params)
    @product.merchant_id = session[:merchant]['id']

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

  def categories
    @categories = Category.all.sort_by{|c| c.name}
  end

  def add_categories
    params[:id] = params[:product_id]
    find_product_by_params
    puts params
    puts "controller"
    return redirect_to product_path(@product.id)
  end

  private

  def find_product_by_params
    @product = Product.find(params[:id])

    unless @product
      return head :not_found
    end
  end

  def confirm_ownership
    unless session[:merchant]['id'] == @product.merchant_id
      flash[:status] = :failure
      flash[:message] = "Only a product's merchant can modify a product."
      return redirect_back(fallback_location: products_path)
    end
  end

  def prod_params
    params.require(:product).permit(:name, :image_url, :price, :quantity, :description)
  end
end
