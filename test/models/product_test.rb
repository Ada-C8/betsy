require "test_helper"

<<<<<<< HEAD
describe Product do
  describe "validations" do
    it "requires a name" do
      products(:pointy_hat).merchant = Merchant.first
      products(:pointy_hat).save
      products(:pointy_hat).valid?.must_equal true


      products(:missing_name).merchant = Merchant.first
      products(:missing_name).save
      products(:missing_name).valid?.must_equal false

      products(:missing_name).name = "Another pointy hat"
      products(:missing_name).save
      products(:missing_name).valid?.must_equal true
    end

    it "needs a name that is a string" do

    end

    it "requires a price" do
      test = Product.new(name: "Caldroun", quantity_avail: 1, merchant: Merchant.first)
      test.valid?.must_equal false

      test.price = 59.99
      test.valid?.must_equal true
    end

    it "requires a price that is a number" do
      test = Product.new(name: "Caldroun", quantity_avail: 1, price: "cats", merchant: Merchant.first)
      test.valid?.must_equal false
    end

    it "requires a price that is greater than 0" do
      test = Product.new(name: "Caldroun", quantity_avail: 1, price: -2.50, merchant: Merchant.first)
      test.valid?.must_equal false

      another = Product.new(name: "Caldroun", quantity_avail: 1, price: 0, merchant: Merchant.first)
      another.valid?.must_equal false
    end

    it "requires a quantity_avail" do
      test = Product.new(name: "Caldroun", price: 68.50, merchant: Merchant.first)
      test.valid?.must_equal false

      test.quantity_avail = 1
      test.valid?.must_equal true
    end

    it "can have a quantity_avail of 0" do
      test = Product.new(name: "Caldroun", quantity_avail: 0, price: 68.50, merchant: Merchant.first)
      test.valid?.must_equal true
    end

    it "cannot have a quantity_avail less than 0" do
      test = Product.new(name: "Caldroun", quantity_avail: -1, price: 68.50, merchant: Merchant.first)
      test.valid?.must_equal false
    end
  end

  describe "relations" do
    it "has a merchant" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      test.merchant.must_equal Merchant.first

      test.merchant.id.must_equal Merchant.first.id
    end

    it "has reviews" do
      test = Product.create(name: "Caldroun", quantity_avail: 5, price: 68.50, merchant: Merchant.first)
      review = Review.create(rating: 5, text_review: "This was better than my cast iron pan!", product_id: test.id)
      test.reviews.must_include review
      test.reviews[0].must_be_kind_of Review
    end

  end
end
=======
# describe Product do
#   describe "validations" do
#     it "requires a name" do
#       products(:pointy_hat).merchant = Merchant.first
#       products(:pointy_hat).save
#       products(:pointy_hat).valid?.must_equal true
#
#
#       products(:missing_name).valid?.must_equal false
#
#       products(:missing_name).name = "Another pointy hat"
#       products(:missing_name).save
#       products(:missing_name).valid?.must_equal true
#     end
#
#   end
# end
>>>>>>> 3f4fd4d742b658965db7e14655d5c2ec436d641b
