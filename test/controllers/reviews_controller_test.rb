require "test_helper"

describe ReviewsController do
  let(:review) { reviews(:review) }
  let(:mermaid_fin) { products(:mermaid_fin) }

  def login_test_user
    user = merchants(:ada)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
    get login_path(:github)
  end

  describe "new" do
    # it " should work without a merchant id" do
    #   get new_review_path
    #   must_respond_with :success
    # end

    it " should not work if product belongs to merchant " do
      # Arrange
      login_test_user
      review_data = {
        review: {
          rating: 5,
          product_id: mermaid_fin.id
        }
      }
      # Act
      get reviews_path, params: review_data
      # Assert
      must_respond_with :redirect
      must_redirect_to product_path(mermaid_fin)
    end
  end



  describe "create" do
    describe " logged in users" do
      it "should return failure if product belongs to merchant " do
        # arrange: login 'ada' user
        login_test_user
        review_data = {
          review: {
            rating: 5,
            product_id: mermaid_fin.id
          }
        }

        # act: review (Mermaid Fin)
        post reviews_path, params: review_data

        # assert: expect failure.
        must_respond_with :redirect
        must_redirect_to product_path(mermaid_fin)
      end

      # it " should "
    end
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
  #
  describe "edit" do
  # #   it "will give error message if merchant owns the product" do
  # #     arrange: login 'ada' user
  # #     login(users(:ada))
  # #     # act: review (Mermaid Fin)
  # #     review_data = {
  # #       review: {
  # #         rating: 5,
  # #         product: (products(:mermaid_fin))
  # #       }
  # #     }
  # #     # assert: expect failure.
  # #     must_respond_with :unauthorized
  # #   end
  # #
    it "succeeds for an exact review ID" do
      get edit_review_path(reviews(:review))
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus review ID" do
      bogus_review_id = Review.last.id + 1
      get edit_review_path(bogus_review_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "will successfully update review" do
      rev = Review.first
      review_data = {
        review: {
          rating: 3,
          product: products(:mermaid_fin).attributes
        }
      }

      patch review_path(rev), params: review_data

      must_respond_with :redirect
      must_redirect_to review_path(rev)

      Review.find(rev.id).rating.must_equal rev.rating + 1
    end
  #
  #   it "will return not found, if review doesn't exist" do
  #     bad_id = Review.last.id + 1
  #     review_data = {
  #       review:{
  #         rating: 3,
  #         description: "It is a good product "
  #       }
  #     }
  #     patch review_path(bad_id), params: review_data
  #     must_respond_with :not_found
  #   end
  #
  #   it "will not let you invalidate work item" do
  #     w = Work.first
  #     work_data = {
  #       id: w.id,
  #       work: {
  #         title: "" # Clearing the title
  #       }
  #     }
  #
  #     patch work_path(w), params: work_data
  #
  #     must_respond_with :bad_request
  #
  #     Work.find(w.id).title.must_equal w.title
  #   end
  end
end
