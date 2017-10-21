class ReviewsController < ApplicationController
  before_action :find_review_by_params_id, only: [:edit, :update, :destroy]
  before_action :check_for_product_owner, only: [:create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:status] = :success
      flash[:message] = "Successfully created review "
      redirect_to product_path(@product)
    else
      flash[:status] = :failure
      flash[:message] = "Failed to create review"
      render :new, status: :bad_request
    end
  end

  def edit ; end
  #
  def update
    #   #TODO add owner check
        @review.update_attributes(review_params)
        if @review.save
          flash[:status] = :success
          flash[:message] = "Successfully created review "
          redirect_to product_path(@product)
        else
          render :edit, status: :bad_request
          return
        end
  end

  def destroy
    # @review.destroy
    # flash[:status] = :success
    # flash[:result_text] = "Successfully destroyed review  by #{@merchant.username}"
    # redirect_to product_path
  end

  private

  def review_params
    @review =(params.require(:review).permit(:rating, :description, :merchant_id, :product_id))
  end

  def find_review_by_params_id
    @review = Review.find_by(id: params[:id])
    unless @review
      head :not_found
    end
  end

  def check_for_product_owner
    @product = Product.find_by(id: params[:review][:product_id])
    unless @product
      head :not_found
    end
    if session[:merchant] && @product.merchant_id == session[:merchant][:id]
      flash[:status] = :failure
      flash[:result_text] = "Owner can not review the product!"
      redirect_to product_path(@product)
    end
  end
end
