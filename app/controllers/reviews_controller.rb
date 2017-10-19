class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new(product_id: params[:product_id])
  end

  def create
    @review = Review.new(params[:review][:product_id], text_review: params[:review][:text_review], rating: [:review][:rating])
    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Successfully reviewed!"
      redirect_to product_path(@review.product_id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not review this product."
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

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
