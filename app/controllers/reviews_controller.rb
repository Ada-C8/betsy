class ReviewsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  before_action :set_product, only: [:new, :create, :show]

  # def index
  #   @reviews = @product.reviews
  # end

  def new
      @review = @product.reviews.build
  end

  def create
    #@product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    if @review.save
      flash[:status] = :success
      flash[:message] = "Thanks for the review!"
      redirect_to @product
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Review failed to save"
      flash.now[:details] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
    unless @review
      head :not_found
    end
  end

  private
  # def set_product
  #   @product = Product.find_by(id: params[:id])
  #   unless @product
  #     head :not_found
  #   end
  # end

  def set_product
    @product = Product.find_by(id: params[:product_id])
    unless @product
      head :not_found
    end
  end

  def review_params
    return params.require(:review).permit(:product_id, :rating, :reviewtext)
  end

end
