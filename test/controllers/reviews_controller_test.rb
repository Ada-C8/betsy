require "test_helper"

describe ReviewsController do
  let(:review) { reviews(:review) }
  let(:mermaid_fin) { products(:mermaid_fin) }
  let(:wand) { products(:wand) }

######### Leaving for future, if we rethink and decide to add later
  # describe "index" do
  #   it "returns success status for all reviews" do
  #     get reviews_path
  #     must_respond_with :success
  #   end
  #
  #   it "works when there are no reviews" do
  #     Review.destroy_all
  #     get reviews_path
  #     must_respond_with :success
  #   end
  # end

  # describe "show" do
  #   it "succeeds for a review that exists" do
  #     get review_path(reviews(:review))
  #     must_respond_with :success
  #   end
  #
  #   it "returns 404 not_found for a review that does not exist" do
  #     get review_path(123)
  #     must_respond_with :not_found
  #   end
  # end

  describe "new" do

    it " should not work if product doesn't exist" do
      bad_product = Product.last.id + 1
      get new_product_review_path(bad_product)

      must_respond_with :not_found
    end

    it " should work for a non-user" do
      logout_test_user
      get new_product_review_path(mermaid_fin)
      must_respond_with :success
    end

    it " should not work if product belongs to merchant " do
      # Arrange
      login_test_user

      # Act
      get new_product_review_path(mermaid_fin)

      # Assert
      must_respond_with :redirect
      must_redirect_to product_path(mermaid_fin)
    end
  end

  describe "create" do

    # We are already checking "new" method for owenership
    # it "should return failure if product belongs to merchant " do
    #   # arrange: login 'ada' user
    #   login_test_user
    #   review_data = {
    #     review: {
    #       rating: 5,
    #       product_id: mermaid_fin.id
    #     }
    #   }
    #   start_review_count = Review.count
    #   # binding.pry
    #   # act: review (Mermaid Fin)
    #   post reviews_path, params: review_data
    #
    #   # assert: expect failure.
    #   must_respond_with :redirect
    #   must_redirect_to product_path(mermaid_fin)
    #   Review.count.must_equal start_review_count
    # end

    it "adds the review to the product and redirects when the review data is valid" do
      # Arrange
      review_data = {
        review: {
          rating: 5,
          product_id: mermaid_fin.id
        }
      }
      start_review_count = Review.count
      # Act
      post reviews_path, params: review_data
      # Assert
      must_redirect_to product_path(mermaid_fin)
      Review.count.must_equal start_review_count + 1
    end


    it "sends bad_request if review data is invalid" do
      # Arrange
      invalid_review_data = {
        review: {
          #No rating
          product_id: mermaid_fin.id
        }
      }
      # Double checking the data is truly invalid
      Review.new(invalid_review_data[:review]).wont_be :valid?
      start_review_count = Review.count

      # Act
      post reviews_path, params: invalid_review_data

      # Assert
      must_respond_with :bad_request
      Review.count.must_equal start_review_count
    end
  end

  describe "edit" do

    before do
      login_test_user
    end

    it "will return failure if merchant owns the product" do
      # login_test_user

      get edit_review_path(review)

      must_redirect_to product_path(mermaid_fin)
    end

    it "succeeds for an exact review ID" do

      review_id = Review.first.id
      get edit_review_path(review.id)
      must_respond_with :found
    end

    it "renders 404 not_found for a bogus review ID" do
      bogus_review_id = Review.last.id + 1
      get edit_review_path(bogus_review_id)
      must_respond_with :not_found
    end
  end

  describe "update" do

    it "will successfully update review" do
      review_data = {
        review: {
          rating: 3,
          product: mermaid_fin.attributes
        }
      }

      patch review_path(review.id), params: review_data

      must_respond_with :redirect
      must_redirect_to product_path(mermaid_fin)

      Review.find(review.id).rating.must_equal 3
    end

      it "will return not found, if review doesn't exist" do
        bad_id = Review.last.id + 1
        review_data = {
          review:{
            rating: 3,
            description: "It is a good product "
          }
        }
        patch review_path(bad_id), params: review_data
        must_respond_with :not_found
      end

      it "will not let you invalidate review" do
        review_data = {
          review: {
            rating: 'shdfgsjh',
            product: mermaid_fin.attributes
          }
        }

        patch review_path(review.id), params: review_data

        must_respond_with :bad_request
      end
  end

  describe "destroy" do

    before do
      login_test_user
    end

    it "will successfully destroy review" do
    
      start_review_count = Review.count

      delete review_path(reviews(:review4))
      # binding.pry
      must_redirect_to product_path(wand.id)

      flash[:status].must_equal :success
      Review.count.must_equal start_review_count - 1
    end

    it "will not delete review if merchant owns the product" do
      # login_test_user
      start_review_count = Review.count
      delete review_path(review)

      must_redirect_to product_path(mermaid_fin.id)
      Review.count.must_equal start_review_count
    end
  end
end
