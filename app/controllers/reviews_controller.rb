class ReviewsController < ApplicationController
  before_action :verify_product_exists, only: [:new, :create]
  before_action :find_review, only: [:edit, :update, :show]

  # NESTED ROUTES - will have a product id
  def new
    @review = Review.new
    @review.product_id = params[:product_id]

    # create new user if user doesn't already exist
    user = session[:user_id] ? User.find_by(id: session[:user_id]) : User.create

    # if user id matches merchant's user id, deny access
    # merchant can't review their own products
    if user.id == @product.merchant.user_id
      flash[:status] = :failure
      flash[:message] = "You're not allowed to review your own products"

      redirect_to root_path
      return
    end

    @review.user_id =user.id
  end

  def create
    # WISHLIST - only allow users to review products they've purchased (SHOULD BE prevented at db level)
    @review = Review.new(review_params)

    if @review.save
      flash[:status] = :success
      flash[:message] = "Thank you for reviewing #{@product.name}!"

      redirect_to product_path(@product)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Unable to post review of #{@product.name}"
      flash.now[:details] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  # NOT NESTED ROUTES
  def edit
    # only allow user to edit if current user_id matches user_id of person who created the review
    unless @review
      render_404
      return
    end

    if @review.user_id != session[:user_id]
      flash[:status] = :failure
      flash[:message] = "You can only edit reviews you wrote"
      redirect_back fallback_location: root_path
    end
  end

  def update
    unless @review
      render_404
      return
    end

    if @review.update_attributes(review_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated review of #{@review.product.name.pluralize}"

      redirect_to product_path(@review.product)
    else
      flash[:status] = :failure
      flash[:message] = "Could not update your review."
      flash[:details] = @review.errors.messages

      render :edit, status: :bad_request
    end
  end

  def show
    render_404 unless @review
  end

  private

  def review_params
    return params.require(:review).permit(:product_id, :user_id, :rating, :text)
  end

  def verify_product_exists
    @product = Product.find_by(id: params[:product_id])

    unless @product
      flash[:status] = :failure
      flash[:message] = "Product does not exist"
      redirect_to root_path
    end
  end

  def find_review
    @review = Review.find_by(id: params[:id])
  end


end
