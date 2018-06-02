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

  describe "get_rating_stars" do
    it 'returns 1 star if given a rating of 0-1' do
      Review.get_rating_stars(0).must_equal "⭑⭒⭒⭒⭒"
      Review.get_rating_stars(0.5).must_equal "⭑⭒⭒⭒⭒"
      Review.get_rating_stars(1.0).must_equal "⭑⭒⭒⭒⭒"
    end

    it 'returns 2 star if given a rating of 1-2' do
      Review.get_rating_stars(1.5).must_equal "⭑⭑⭒⭒⭒"
      Review.get_rating_stars(2).must_equal "⭑⭑⭒⭒⭒"
    end

    it 'returns 3 star if given a rating of 2-3' do
      Review.get_rating_stars(2.5).must_equal "⭑⭑⭑⭒⭒"
      Review.get_rating_stars(3).must_equal "⭑⭑⭑⭒⭒"
    end

    it 'returns 4 star if given a rating of 3-4' do
      Review.get_rating_stars(3.5).must_equal "⭑⭑⭑⭑⭒"
      Review.get_rating_stars(4).must_equal "⭑⭑⭑⭑⭒"
    end

    it 'returns 5 star if given a rating of greater than 4' do
      Review.get_rating_stars(4.5).must_equal "⭑⭑⭑⭑⭑"
      Review.get_rating_stars(5).must_equal "⭑⭑⭑⭑⭑"
      Review.get_rating_stars(6).must_equal "⭑⭑⭑⭑⭑"
    end

    it 'returns empty string if rating is nil or empty' do
      Review.get_rating_stars("").must_equal ""
      Review.get_rating_stars(nil).must_equal ""
    end
  end
end
