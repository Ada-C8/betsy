class ReviewsController < ApplicationController
  before_action :find_review_by_params_id, only: [:edit, :update, :destroy] #:show,
  before_action :check_for_product_owner_nested, only: [:new]
  before_action :check_for_product_owner, only: [:edit, :update, :destroy, :create]

  # def index      # leaving for future, if we rethink and decide to add later
  #   @reviews = Review.where(product_id: params[:product_id])
  # end

  # def show ; end

  def new
    @review = Review.new(product_id: params[:product_id])
  end

  def create
    @review = Review.new(review_params)

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
    if @review.save
      flash[:status] = :success
      flash[:message] = "Successfully created review "
      redirect_to product_path(@review.product_id)
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @review.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed review"
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
end
