class ReviewsController < ApplicationController
  #ToDo need destroy? if so, update.
  #maybe no index or show
  def index
    # if params[:product_id] != nil
    #   @reviews = Review.where(product_id: params[:product_id])
    #   @review_show_route = product_reviews_path
    # else
    #   @reviews = Review.all
    # end
  end

  def new
    @product = Product.find_by(id: params[:product_id])
    @review = Review.new
  end

  def create
    puts params
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    # @review.rating = @review.rating.to_i

    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Successfully reviewed!"
      # redirect_to root_path
      redirect_to product_path(@review.product_id)
    else
      puts "the new model"
      puts @review
      puts @review.rating
      puts @review.text_review
      flash[:status] = :failure
      flash[:result_text] = "Could not review this product."
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    # if params[:product_id] != nil
    #   @review = Review.find_by(product_id: params[:product_id], id: params[:id])
    #   @review_path = product_reviews_url
    # else
    #   @review = Review.find(params[:id])
    #   @review_path = reviews_url
    # end
    # unless @review
    #   redirect_to root_path, status: :not_found
    # end
  end
#Do we want to destroy reviews? If so, must update method to include if params [:product_id] != nil redirect_to product_reviews_url
  def destroy
    # @review = Review.find_by(id: params[:id])
    # if @review.destroy
    #   flash[:status] = :success
    #   flash[:result_text] = "Review deleted"
    #   redirect_to products_path
    # else
    #   flash[:status] = :failure
    #   flash[:result_text] = "That review is unable to be deleted."
    # end
  end
  private

 def review_params
    params.require(:review).permit(:rating, :text_review)
 end
end
