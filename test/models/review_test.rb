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

      review.rating = 5
      review.valid?.must_equal true
    end

    it "requires a rating to be an integer betwene 1 and 5" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.new(rating: 0, text_review: "This was better than my cast iron pan!", product_id: test.id)
      review.valid?.must_equal false

      review.rating = 9
      review.valid?.must_equal false
    end
  end
end
