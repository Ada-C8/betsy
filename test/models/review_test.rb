require "test_helper"

describe Review do
  let(:review) { reviews(:review) }

  describe "validations" do
    it "will return false without a rating" do
      review.rating = nil
      review.valid?.must_equal false
    end

    it "will return false if rating is not an integer" do
      review.rating = 3.1
      review.valid?.must_equal false
    end

    it "will return false if rating is not in range of 1-5" do
      review.rating = 6
      review.valid?.must_equal false

      review.rating = 0
      review.valid?.must_equal false
    end
  end

  describe "relations" do
    it 'belongs to merchants' do
      Review.reflect_on_association(:merchant)
    end

    it "valid even if it does not belong to a merchant" do
      review.merchant = nil
      review.valid?.must_equal true
    end

    it 'belongs to products' do
      Review.reflect_on_association(:product)
    end

    it "invalid if it has no product" do
      review.product_id = nil
      review.valid?.must_equal false
    end
  end
end
