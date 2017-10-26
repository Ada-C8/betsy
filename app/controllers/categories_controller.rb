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
      redirect_to category_path(@category)
    else
      render :edit, status: :bad_request
    end
  end

  #Need to set this so that it can only be destroyed if there are no products assigned to it. category.products must be empty

  def destroy
    @category = Category.find_by(id: params[:id])

    unless @category
      head :not_found
      return
    end

    if @category.products.count != 0
      flash.now[:status] = :failure
      flash.now[:message] = "Can't delete a category that contains products."
      redirect_to categories_path, status: :bad_request

    else
      @category.destroy
      flash.now[:status] = :success
      flash.now[:message] = "Category Deleted"
      redirect_to categories_path
    end

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
