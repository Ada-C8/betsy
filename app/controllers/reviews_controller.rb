class ReviewsController < ApplicationController
  before_action :find_review_by_params_id, only: [:edit, :update, :destroy] #:show,
  before_action :check_for_product_owner_nested, only: [:new]
  before_action :check_for_product_owner, only: [:edit, :update, :destroy]
  before_action only: [:edit, :destroy] do

    confirm_object_ownership(@review, @review.merchant_id)
  end
  # leaving for future, if we rethink and decide to add later
  # def index
  #   @reviews = Review.where(product_id: params[:product_id])
  # end

  # def show ; end

  def new
    @review = Review.new
    @review.product_id = params[:product_id]
  end

  def create
    @review = Review.new(review_params)
    @review.merchant_id = session[:merchant]["id"] if session[:merchant]
    if @review.save
      flash[:status] = :success
      flash[:message] = "Successfully created review "
      redirect_to product_path(@review.product)
    else
      flash[:status] = :failure
      flash[:message] = "Failed to create review"
      render :new, status: :bad_request
    end
  end

  def edit ; end

  def update
    @review.update_attributes(review_params)
    result = @review.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully created review "
      redirect_to product_path(@review.product_id)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not update the review"
      flash.now[:details] = @review.errors.messages
      return render :edit, status: :bad_request
    end
  end

  def destroy
    @review.destroy
    flash[:status] = :success
    flash[:message] = "Successfully destroyed review"
    redirect_to product_path(@review.product_id)
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :description, :merchant_id, :product_id)
  end

  def find_review_by_params_id
    @review = Review.find_by(id: params[:id])
    unless @review
      head :not_found
    end
  end

  def check_for_product_owner
    if !session[:merchant].nil? && @review.product.merchant_id == session[:merchant]["id"]
      flash[:status] = :failure
      flash[:message] = "Owner can not edit the review of the product!"
      redirect_to product_path(@review.product_id)
    end
  end

  def check_for_product_owner_nested
    @product = Product.find_by(id: params[:product_id])
    unless @product
      head :not_found
    end
    if !session[:merchant].nil? && @product.merchant_id == session[:merchant]["id"]
      flash[:status] = :failure
      flash[:message] = "Owner can not review the product!"
      redirect_to product_path(@product)
    end
  end

  # def check_for_product_owner
  #   unless session[:merchant].nil?
  #     if @review.merchant_id == session[:merchant]["id"]
  #       flash[:status] = :failure
  #       flash[:result_text] = "Owner can not edit the review of the product!"
  #       redirect_to product_path(@review.product_id)
  #     end
  #   end
  # end
  #
  # def check_for_product_owner_nested
  #   @product = Product.find_by(id: params[:product_id])
  #   unless @product
  #     head :not_found
  #   end
  #   if !session[:merchant].nil? && @product.merchant_id == session[:merchant]["id"]
  #     flash[:status] = :failure
  #     flash[:result_text] = "Owner can not review the product!"
  #     redirect_to product_path(@product)
  #   end
  # end
end
