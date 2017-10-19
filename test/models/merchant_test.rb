require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new( username: 'testman',
    email: 'test@test.com',
    oauth_provider: 'github',
    oauth_uid: '1234567')
  }

  # it "must be valid" do
  #   value(merchant).must_be :valid?
  # end

  describe 'validations' do
    it 'can be created with valid data' do
      merchant.must_be :valid?
    end

    describe 'username' do
      it 'requires username' do
        merchant.username = nil
        merchant.email = 'test@test.com'
        merchant.oauth_provider = 'github'
        merchant.oauth_uid = '1234567'
        merchant.save
        merchant.errors.messages.must_include :username
        merchant.wont_be :valid?
      end
      it "has a unique username" do
        merchant.username = "countess_ada"
        merchant.wont_be :valid?
        merchant.errors.messages.must_include :username
      end
    end

    describe "username email validations" do
      describe "tests for format of email" do

        it "will reject a bad email" do
          merchant.email = "I'm an email"
          merchant.wont_be :valid?
          merchant.errors.messages.must_include :email
        end
      end

      describe "tests for presence of email" do
        it "will reject missing email" do
          merchant.email = nil
          merchant.wont_be :valid?
          merchant.errors.messages.must_include :email
        end
      end
    end

    describe "oauth validations" do
      it "will reject not unique oauth_uid" do
        merchant.oauth_uid = "12345"
        merchant.wont_be :valid?
        merchant.errors.messages.must_include :oauth_uid
      end
    end

    describe "oauth_provider" do
      it "will be rejected if oauth_provider not present" do
        merchant.oauth_provider = nil
        merchant.wont_be :valid?
        merchant.errors.messages.must_include :oauth_provider
      end
    end
  end

  describe 'relationships' do
    it "has a list of products" do
      mermaid_fin = merchants(:ada)
      mermaid_fin .must_respond_to :products
      mermaid_fin.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "has a list of reviews" do
      review = merchants(:ada)
      review.must_respond_to :reviews
      review.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end

    it "has a list of orders" do
      order = merchants(:ada)
      order.must_respond_to :orders
      order.orders.each do |order|
        order.must_be_kind_of Order
      end
    end

    it "has a list of order products" do
      order_product = merchants(:ada)
      order_product.must_respond_to :order_products
    end
  end
end
