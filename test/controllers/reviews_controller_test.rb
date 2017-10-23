require "test_helper"
#test for create and destroy are commented out and not working
#might need edge cases
#test for 404 missing failing
describe ReviewsController do
  # describe "index" do
  #   it "succeeds with many reviews" do
  #     # Review.count.must_be :>, 0
  #
  #     get product_reviews_path
  #     must_respond_with :success
  #   end
  #   it "succeeds with no reviews" do
  #     Review.destroy_all
  #
  #     get product_reviews_path
  #     must_respond_with :success
  #   end
  # end
  describe "new" do
    it "reviews" do
      get new_product_review_path(:product_id=>products(:pointy_hat).id)
      must_respond_with :success
    end
  end

  describe "create" do
    it "should be able to create a review" do
      proc{
        post product_reviews_path(products(:sad_hat).id), params: {review: {rating: 3, text_review: "Smokin."}  }
      }.must_change 'Review.count', 1

      must_respond_with :redirect
      must_redirect_to product_path(Review.last.product_id)
    end

 it "should rerender the form if it can't create the review" do
    proc   {
    post product_reviews_path(products(:sad_hat).id), params: { review: {rating: nil, text_review: "Smokin.", product_id: products(:pointy_hat).id}  }
  }.must_change 'Review.count', 0

      must_respond_with :bad_request
    end

  end
  # describe "show" do
  #   it "can show a review" do
  #     get product_review_path( reviews(:reviewer).id )
  #
  #     must_respond_with :success
  #   end
  #   it "should respond with 404 if it's not found" do
  #    review = Review.last.id + 1
  #
  #    get product_review_path(review)
  #
  #    must_respond_with :not_found
  #  end
  # end
  # describe "destroy" do
  #   #need to either fix seed data or test differently
  #     it "can delete a review" do
  #
  #       review = reviews(:reviewer)
  #       delete review_path( review.id )
  #       must_redirect_to products_path
  #
  #
  #       Review.find_by(id: review.id).must_be_nil
  #     end
  #   end
end
