require "test_helper"

describe ReviewsController do

  describe "new" do
    it "returns success with a valid product_id" do
      product_id = Product.first.id
      get new_product_review_path(product_id)
      must_respond_with :success
    end #valid id

    it "returns not found in product doesn't exist" do
      product_id = Product.last.id + 1
      get new_product_review_path(product_id)
      must_respond_with :not_found
    end #no product

  end #new tests
  # @product = Product.find(params[:product_id])
  # @review = @product.reviews.build(review_params)

    describe "create" do
      it "creates a review when data is valid" do

        review_data = {
          review: {
            product_id: 1,
            rating: 3,
            reviewtext: "review text"
          }
        }
        product = Product.first
        start_review_count = Review.count
        a = product.reviews.build(review_data[:review])
        a.must_be :valid?

        post product_reviews_path, params:review_data

        must_respond_with :redirect
        must_redirect_to root_path

        Review.count.must_equal start_review_count + 1

      end #valid data test


      # it "will not create a new cateogry when data is invalid" do
      #   invalid_category_data = {
      #     category: {
      #       category_name: ""
      #     }
      #   }
      #   start_category_count = Category.count
      #
      #   Category.new(invalid_category_data[:category]).wont_be :valid?
      #
      #   post categories_path, params: invalid_category_data
      #   must_respond_with :bad_request
      #
      #   Category.count.must_equal start_category_count
      # end #invalid data test
    end #create tests



end #all tests
# product_reviews GET    /products/:product_id/reviews(.:format)     reviews#index
#                 POST   /products/:product_id/reviews(.:format)     reviews#create
# new_product_review GET    /products/:product_id/reviews/new(.:format) reviews#new
#
#     describe "show" do
#       # Just the standard show tests
#       it "succeeds for a book that exists" do
#         book_id = Book.first.id
#         get book_path(book_id)
#         must_respond_with :success
#       end
#
#       it "returns 404 not_found for a book that D.N.E." do
#         book_id = Book.last.id + 1
#         get book_path(book_id)
#         must_respond_with :not_found
#       end
#     end
#   end
