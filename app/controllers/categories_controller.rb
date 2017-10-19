class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name])
    if @category.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created #{@category.name} category"
      redirect_to category_path(@category.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@category.name} category."
      flash[:messages] = @category.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
    if @category == nil
      flash[:status] = :failure
      flash[:result_text] = "That category does not exist."
      redirect_to categories_path, status: :not_found
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.destroy
      flash[:status] = :success
      flash[:result_text] = "Category deleted"
      redirect_to categories_path
    else
      flash[:status] = :failure
      flash[:result_text] = "That category is unable to be deleted."
    end
  end

end
