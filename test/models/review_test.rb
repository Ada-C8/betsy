require "test_helper"
describe Review do

  describe "validations" do
    it "requires a rating" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.valid?.must_equal false

      review.rating = 5
      review.valid?.must_equal true
    end

    it "requires a rating to be an integer" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(rating: "cats", text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.valid?.must_equal false


      review = Review.new(rating: "cats", text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.rating = "Cats Rule!"
      review.valid?.must_equal false

      review = Review.new(rating: "cats", text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.rating = 5
      review.valid?.must_equal true
    end

    it "requires a rating to be an integer betwene 1 and 5" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(rating: 0, text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.valid?.must_equal false

      review.rating = 9
      review.valid?.must_equal false

      review.rating = 0
      review.valid?.must_equal false

      review.rating = -4
      review.valid?.must_equal false
    end

    it "requires a product_id" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(text_review: "This was better than my cast iron pan!", rating: 4)
      review.valid?.must_equal false

      review = Review.new(text_review: "This was better than my cast iron pan!", rating: 4, product_id: test.id)
      review.valid?.must_equal true
    end

    it "requires a valid product id" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(text_review: "This was better than my cast iron pan!", rating: 4, product_id: "CATSZZZ")
      review.valid?.must_equal false

      review = Review.new(text_review: "This was better than my cast iron pan!", rating: 4, product_id: test.id)
      review.valid?.must_equal true
    end
  end

  describe "relations" do
    it "belongs to a product" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.create(text_review: "This was better than my cast iron pan!", rating: 4, product_id: test.id)

      test.reviews.must_include review
    end

    it "is not associated with a product other than the one it belongs to" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.create(text_review: "This was better than my cast iron pan!", rating: 4, product_id: Product.first)

      test.reviews.wont_include review
    end

    it "is is an empty collection if a product has no reviews" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)

      test.must_respond_to :reviews
      test.reviews.count.must_equal 0
    end
  end
end
