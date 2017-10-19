require "test_helper"

describe ReviewsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  let (:review) {reviews(:review1)}

  describe "new" do
    it "creates a new review successfully" do
      @product = Product.first.id
      get new_product_review_path(@product)
      must_respond_with :success
    end
  end

  describe "create" do
    #  BOTH create tests need :product_id! HOW DO WE PASS IN?

  #   it "saves and redirects to product show page when the review data is valid" do
  #    review_data = {
  #      review: {
  #        rating: 3,
  #        text: "I loved it!",
  #      }
  #    }
  #    @product =  Product.first.id
  #    Review.new(review_data[:review]).must_be :valid?
  #    start_review_count = Review.count
  #
  #    post new_product_review_path, params: product_data
  #    must_respond_with :redirect
  #    must_redirect_to product_path(@product)
  #    Review.count.must_equal start_review_count + 1
  #  end


  #   it "renders a bad_request when the review data is invalid" do
  #     bad_review = {
  #       review: {
  #         rating: "",
  #         # no rating given!!
  #       }
  #     }
  #     Review.new(bad_review[:review]).wont_be :valid?
  #     start_review_count = Review.count
  #     post new_product_review_path, params: bad_review
  #
  #     must_respond_with :bad_request
  #     Review.count.must_equal start_review_count
  #   end
  #   # need to write test for when create is not allowed (not merchant_id)
  end



end
