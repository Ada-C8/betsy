require "test_helper"


describe Review do
  let(:review) { Review.new }

  words = "a" * 500
  long = "a" * 501

  it "can be created with required fields" do
    b = Review.new(rating: 1, product_id: Product.first.id)
    b.must_be :valid?
  end #can be created

  it "can only take an integer between 1 and 5 as a rating" do
    b = Review.new(rating: 10, product_id: Product.first.id)
    b.wont_be :valid?
    b.errors.messages.must_include :rating
  end

  it "will allow a text review up to 500 characters" do
    b = Review.new(rating: 1, product_id: Product.first.id, reviewtext: words)
    b.must_be :valid?
  end

  it "will not accept a text review over 500 characters" do
    b = Review.new(rating: 1, product_id: Product.first.id, reviewtext: long)
    b.wont_be :valid?
    b.errors.messages.must_include :reviewtext
  end

end
