class ReviewsController < ApplicationController
  #ToDo need destroy? if so, update.
  def index
    if params[:product_id] != nil
      @reviews = Review.where(product_id: params[:product_id])
      @review_show_route = product_reviews_path
    else
      @reviews = Review.all
    end
  end

  def new
    @product = Product.find_by(id: params[:product_id])
    @review = Review.new(product_id: params[:product_id])
  end

  def create
    @review = Review.new(product_id: params[:review][:product_id], text_review: params[:review][:text_review],rating: params[:review][:rating])
    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Successfully reviewed!"
      redirect_to product_reviews_path(id: @review.id, product_id: params[:review][:product_id])
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not review this product."
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    if params[:product_id] != nil
      @review = Review.find_by(product_id: params[:product_id], id: params[:id])
      @review_path = product_reviews_url
    else
      @review = Review.find(params[:id])
      @review_path = reviews_url
    end
    unless @review
      redirect_to root_path, status: :not_found
    end
  end
#Do we want to destroy reviews? If so, must update method to include if params [:product_id] != nil redirect_to product_reviews_url
  def destroy
    @review = Review.find_by(id: params[:id])
    if @review.destroy
      flash[:status] = :success
      flash[:result_text] = "Review deleted"
      redirect_to products_path
    else
      flash[:status] = :failure
      flash[:result_text] = "That review is unable to be deleted."
    end
  end
end
