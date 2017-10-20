class ReviewsController < ApplicationController
  before_action :find_review_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    if params[:product]
      product = Product.find_by(id: params[:product_id])
      if product
        @reviews = product.reviews
      else
        head :not_found
      end
    else
      @reviews = Review.all
    end
  end

#   def new
#     @review = Review.new
#   end
#
#   def create
#     # if params[:merchant]
#     # merchant = Merchant.find_by(id:session[:logged_in_merchant])
#     # if merchant.product
#     #   flash[:status] = :failure
#     #   flash[:result_text] = "You can not review your own product"
#     #   redirect_to product_path
#     # else
#       @review = Review.new(review_params)
#       if @review.save
#         flash[:status] = :success
#         flash[:message] = "Successfully created review "
#         redirect_to review_path(@review)
#       else
#         flash[:status] = :failure
#         flash[:message] = "Failed to create review"
#         flash[:details] = @review.errors.messages
#         render :new, status: :bad_request
#       end
#     # end
#   end
#
#   def show ; end
#
#   def edit ; end
#
#   def update
#   #TODO add owner check
#     @review.update_attributes(review_params)
#     if save_and_flash(@review)
#       redirect_to review_path(@review)
#     else
#       render :edit, status: :bad_request
#       return
#     end
#   end
#
#   def destroy
#     @review.destroy
#     flash[:status] = :success
#     flash[:result_text] = "Successfully destroyed review  by #{@merchant.username}"
#     redirect_to product_path
#   end
#
# private
#
#   def review_params
#     @review =(params.require(:review).permit(:rating, :description, :merchant, :product))
#   end
#
#   def find_review_by_params_id
#     @review = Review.find_by(id: params[:id])
#     unless @review
#       head :not_found
#     end
#   end

# Do we need this method?
  # def require_owner_check
  #   if @review.merchant_id != @login_user.id
  #     flash[:status] = :failure
  #     flash[:result_text] = "You must be owner of the review to do that!"
  #     redirect_to review_path(@review)
  #   end
  # end
end
