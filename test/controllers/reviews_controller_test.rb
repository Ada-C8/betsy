require "test_helper"

describe ReviewsController do
  let(:review) { reviews(:review) }

  describe "index" do
    it "returns success status for all reviews" do
      get reviews_path
      must_respond_with :success
    end

    it "returns a failure status when there are no reviews" do
      Review.destroy_all
      get reviews_path
      must_respond_with :failure
    end
  end

  # describe "new" do
  #   it " should work without a merchant id" do
  #     get new_review_path
  #     must_respond_with :success
  #   end
  #
  #   it "should return failure if product belongs to merchant " do
  #     # arrange: login 'ada' user
  #     login(users(:ada))
  #     # act: review (Mermaid Fin)
  #     review_data = {
  #       review: {
  #         rating: 5,
  #         product: (products(:mermaid_fin))
  #       }
  #     }
  #     # assert: expect failure.
  #     must_respond_with :bad_request
  #   end
  # end
  #
  # describe "create" do
  #   it "adds the review to the product and redirects when the review data is valid" do
  #     # Arrange
  #     review_data = {
  #       review: {
  #         rating: 5,
  #         product: (products(:mermaid_fin))
  #       }
  #     }
  #     Review.new(review_data[:review]).must_be :valid?
  #
  #     start_review_count = Review.count
  #
  #     # Act
  #     post reviews_path, params: review_data
  #
  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to reviews_path
  #
  #     Review.count.must_equal start_review_count + 1
  #   end
  #   #
  #   it "sends bad_request if review data is invalid" do
  #     # Arrange
  #     invalid_review_data = {
  #       review: {
  #         #No rating
  #         product: (reviews(:mermaid_fin))
  #       }
  #     }
  #     # Double checking the data is truly invalid
  #     Review.new(invalid_review_data[:review]).wont_be :valid?
  #
  #     start_review_count = Review.count
  #
  #     # Act
  #     post reviews_path, params: invalid_review_data
  #
  #     # Assert
  #     must_respond_with :bad_request
  #     # assert_template :new
  #     Review.count.must_equal start_review_count
  #   end
  # end
  #
  # describe "show" do
  #   it "succeeds for a review that exists" do
  #     get review_path(reviews(:review))
  #     must_respond_with :success
  #   end
  #
  #   it "returns 404 not_found for a review that does not exist" do
  #     get review_path(reviews(:bad_review))
  #     must_respond_with :not_found
  #   end
  # end
  #
  # describe "edit" do
  #   it "will give error message if merchant owns the product" do
  #     arrange: login 'ada' user
  #     login(users(:ada))
  #     # act: review (Mermaid Fin)
  #     review_data = {
  #       review: {
  #         rating: 5,
  #         product: (products(:mermaid_fin))
  #       }
  #     }
  #     # assert: expect failure.
  #     must_respond_with :unauthorized
  #   end
  #
  #   it "succeeds for an exact review ID" do
  #     get edit_review_path(reviews(:review))
  #     must_respond_with :success
  #   end
  #
  #   it "renders 404 not_found for a bogus review ID" do
  #     bogus_review_id = Review.last.id + 1
  #     get edit_review_path(bogus_review_id)
  #     must_respond_with :not_found
  #   end
  # end
end
