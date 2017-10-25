class ProductsController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy, :categories, :add_categories, :retire] do
    find_object_by_params(Product)
  end

  before_action :confirm_login, except: [:index, :show]

  before_action only: [:edit, :update, :destroy, :categories, :add_categories, :retire] do
    confirm_object_ownership(@product, @product.merchant_id)
  end


  def index
    if params[:category_id]
      if params[:category_id] == 'all'
        @products = Product.all
        @title = "All Products"
      else
        @cat = Category.find_by(id: params[:category_id])
        if @cat
          @products = Product.all.find_all { |prod| prod.categories.include? @cat }
          @title = @cat.name.capitalize
        else
          return head :not_found
        end
      end
    else
      @title = "Popular Now"
      @products = Product.most_popular
    end
    @products = @products.reject {|prod| prod.quantity == 0}
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
      return redirect_to add_categories_path(@product.id)
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
      if request.referer.include?'inventory'
        return redirect_to self_inventory_path
      else
        return redirect_to product_path(@product.id)
      end
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not update product"
      flash.now[:details] = @product.errors.messages
      return render :edit, status: :bad_request
    end
  end

  def destroy
    result = @product.destroy

    flash.now[:status] = :success
    flash.now[:message] = "Successfully deleted #{@product.name}"
    return redirect_to products_path
  end

  def add_categories
    result = @product.add_categories_by_params(params)

    if result
      flash.now[:status] = :success
      flash.now[:message] = "Added category"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not add category"
      flash.now[:details] = @product.errors.messages
    end
    return redirect_to product_path(@product.id)
  end

  def retire
    @product.quantity = 0
    @product.save
    return redirect_to self_inventory_path
  end

  private

  def prod_params
    params.require(:product).permit(:name, :image_url, :price, :quantity, :description)
  end
end
