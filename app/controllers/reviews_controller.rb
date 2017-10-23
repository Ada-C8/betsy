class ReviewsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]


def new
  @product = Product.find(params[:product_id])
  # @review = Review.new
  @review = @product.reviews.build
end

def create
  @product = Product.find(params[:product_id])
  # @review = Review.new(review_params)
  @review = @product.reviews.build(review_params)
  if @review.save
    flash[:status] = :success
    flash[:message] = "Your Review has been Created"
    redirect_to root_path
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
def review_params
  return params.require(:review).permit(:product_id, :rating, :reviewtext)
end

end
