require "test_helper"

describe Product do
  before do
    @product = products(:fake_product1)
  end

  describe 'relationships' do
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

  describe 'validate' do
    it "can be created and required fields cannot be nil" do
      @product.must_be_kind_of Product

      refute_nil @product.id
      refute_nil @product.name
      refute_nil @product.price
      refute_nil @product.stock
      refute_nil @product.merchant_id
      refute_nil @product.category_id
    end

    it "is invalid if any required fields are missing" do
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

    it "requires price to be an integer greater than 0" do
      @product.price = -1
      @product.valid?.must_equal false
      @product.errors.messages.must_include :price

      @product.price = 0
      @product.valid?.must_equal false
      @product.errors.messages.must_include :price

      @product.price = 1
      @product.valid?.must_equal true
    end

    it "requires stock to be greater than or equal to 0" do
      @product.stock = -1
      @product.valid?.must_equal false
      @product.errors.messages.must_include :stock

      @product.stock = 0
      @product.valid?.must_equal true
    end
  end
end
