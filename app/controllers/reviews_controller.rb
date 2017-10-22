class ReviewsController < ApplicationController


def new
  @product = Product.find(params[:product_id])
  @review = Review.new
end

def create
  @review = Review.new(review_params)
  @review = Products.reviews.new(review_params)
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
