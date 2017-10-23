class CategoriesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @categories = Category.all
  end



  def show
    @category = Category.find_by(id: params[:id])
  end

  # def edit
  # end
  #
  # def update
  # end
  #
  # def delete
  # end
  # def new
  #   @category = Category.new
  # end

  # def create
  #   @category = Category.new(category_params)
  #
  #   if @category.save
  #     flash[:status] = :success
  #     flash[:message] = "Successfully created category: #{@category.id}"
  #     redirect_to categories_path
  #   else
  #     flash.now[:status] = :failure
  #     flash.now[:message] = "Failed to create category"
  #     flash.now[:details] = @category.errors.messages
  #     render :new, status: :bad_request
  #   end
  # end
  private
  def category_params
    return params.require(:category).permit(:category_name)
  end
end
