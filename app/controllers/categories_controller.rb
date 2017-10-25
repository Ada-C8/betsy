class CategoriesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:status] = :success
      flash[:message] = "Successfully created category: #{@category.id}"
      redirect_to categories_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create category"
      flash.now[:details] = @category.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    @category = Category.find_by(id: params[:id])
    unless @category
      head :not_found
    end
  end

  def update
    @category = Category.find_by(id: params[:id])
    @category.update_attributes(category_params)
    if @category.save
      redirect_to product_path(@category)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def show
    @category = Category.find_by(id: params[:id])
    unless @category
      head :not_found
    end
  end

  private
  def category_params
    return params.require(:category).permit(:category_name)
  end
end
