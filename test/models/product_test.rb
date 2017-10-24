require "test_helper"

# Are Relations Set up as Expected
# Do my validations catch invalid models and let valid ones through
# Do my custom methods return the correct data?
# Write at least one test for each Custom Method
# Write at least one test for each Model Relationship
# Write at least two tests for each validation (positive and negative)
# Write at least two tests for each scope
#

describe Product do
  # belongs_to :merchant
  # belongs_to :category
  # has_many :order_products
  # has_many :orders, through: :order_products
  # has_many :reviews, dependent: :destroy
  describe 'relationships' do
    describe "relations" do
      it "responds to order" do
        product = products(:fake_product1)
        product.must_respond_to :orders
      end
      #   it "has an author" do
      #     b = books(:poodr)
      #     a = authors(:metz)
      #
      #     binding.pry
      #
      #     b.must_respond_to :author
      #     b.author.must_equal a
      #     b.author_id.must_equal a.id
      #   end
      #
      #   it "has a collection of genres" do
      #     b = Book.new
      #     b.must_respond_to :genres
      #     b.genres.must_be :empty?
      #
      #     g = Genre.create!(name: "test genre")
      #     b.genres << g
      #     b.genres.must_include g
      #   end
    end

    describe 'validate' do
      test 'valid product' do

      end

      test 'invalid without name' do
        user = User.new(email: 'john@example.com')
        refute user.valid?, 'user is valid without a name'
        assert_not_nil user.errors[:name], 'no validation error for name present'
      end

      test 'invalid without email' do
        user = User.new(name: 'John')
        refute user.valid?
        assert_not_nil user.errors[:email]
      end
    end


    describe "validations" do
      it "can be created" do
        sushi = Product.new

        sushi.must_be_kind_of Product
      end #can be created

      it "requires a name" do
        sushi = Product.new
        sushi.name = nil

        sushi.valid?.must_equal false
      end #requires a name

      it "requires a unique name" do
        name = "test name"
        b1 = Product.create!(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)
        b2 = Product.new(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)

        b2.wont_be :valid?
      end #unique name

      it "requires a price" do
        b = Product.new(name: "name", category_id: Category.first.id, merchant_id: Merchant.first.id)
        b.wont_be :valid?
        b.errors.messages.must_include :price
      end

      it "requires price to be greater than 0" do
        b = Product.new(name: "name", price: 0, category_id: 1, merchant_id: 1)
        b.wont_be :valid?
        b.errors.messages.must_include :price
      end

      it "requires an associated merchant" do
        b = Product.new(name: "name", price: "10", category_id: 1)
        b.wont_be :valid?
        b.errors.messages.must_include :merchant_id
      end

      it "requires an associated category" do
        b = Product.new(name: "name", price: "10", merchant_id: 1)
        b.wont_be :valid?
        b.errors.messages.must_include :category_id
      end
    end #validation tests
  end #all product tests
end
