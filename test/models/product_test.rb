require "test_helper"

# Are Relations Set up as Expected
# Do my validations catch invalid models and let valid ones through
# Do my custom methods return the correct data?
# Write at least one test for each Custom Method
# Write at least two tests for each scope

describe Product do
  before do
    @product = products(:fake_product1)
  end
  # belongs_to :merchant
  # belongs_to :category
  # has_many :order_products
  # has_many :orders, through: :order_products
  # has_many :reviews, dependent: :destroy
  describe 'relationships' do
    # Write at least one test for each Model Relationship
    it "responds to merchant" do
      @product.must_respond_to :merchant
    end

    it "responds to category" do
      @product.must_respond_to :category
    end

    it "responds to order_products" do
      @product.must_respond_to :order_products
    end

    it "responds to order" do
      @product.must_respond_to :orders
    end

    it "responds to reviews" do
      @product.must_respond_to :reviews
    end
    # ========================= #
    it "has a merchant" do
      @product.merchant.id.must_equal 1
      @product.merchant.must_equal merchants(:fake_user)
      @product.merchant_id.must_equal merchants(:fake_user).id
    end

    it "has a category" do
      @product.category.id.must_equal 1
      @product.category.must_equal categories(:cat_one)
      @product.category_id.must_equal categories(:cat_one).id
    end
  end

  # validates :name, presence: true
  # validates :price, presence: true, numericality: {
  #   greater_than: 0
  # }
  # validates :stock, presence: true, numericality: {
  #   greater_than_or_equal_to: 0,
  #   only_integer: true
  # }
  # validates :merchant_id, presence: true
  # validates :category_id, presence: true
  #
  # validates_associated :merchant, :category
  describe 'validate' do
    # Write at least two tests for each validation (positive and negative)
    it "can be created and has all required fields" do
      @product.must_be_kind_of Product
      refute_nil @product.id
      refute_nil @product.name
      refute_nil @product.price
      refute_nil @product.stock
      refute_nil @product.merchant_id
      refute_nil @product.category_id
    end

    it "is invalid without required fields" do
      @product.name = nil
      @product.valid?.must_equal false

      @product.price = nil
      @product.valid?.must_equal false

      @product.stock = nil
      @product.valid?.must_equal false

      @product.merchant_id = nil
      @product.valid?.must_equal false

      @product.category_id = nil
      @product.valid?.must_equal false
    end
  #
  #   it 'invalid without email' do
  #     user = User.new(name: 'John')
  #     refute user.valid?
  #     assert_not_nil user.errors[:email]
  #   end
  # end
  #
  #
  #
  # it "requires a unique name" do
  #   name = "it name"
  #   b1 = Product.create!(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)
  #   b2 = Product.new(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)
  #
  #   b2.wont_be :valid?
  # end #unique name
  #
  # it "requires a price" do
  #   b = Product.new(name: "name", category_id: Category.first.id, merchant_id: Merchant.first.id)
  #   b.wont_be :valid?
  #   b.errors.messages.must_include :price
  # end
  #
  # it "requires price to be greater than 0" do
  #   b = Product.new(name: "name", price: 0, category_id: 1, merchant_id: 1)
  #   b.wont_be :valid?
  #   b.errors.messages.must_include :price
  # end
  #
  # it "requires an associated merchant" do
  #   b = Product.new(name: "name", price: "10", category_id: 1)
  #   b.wont_be :valid?
  #   b.errors.messages.must_include :merchant_id
  # end
  #
  # it "requires an associated category" do
  #   b = Product.new(name: "name", price: "10", merchant_id: 1)
  #   b.wont_be :valid?
  #   b.errors.messages.must_include :category_id
  end
end #validation tests
