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
    it "has a list of order_products" do
      mermaid_fin = merchants(:ada)
      mermaid_fin.must_respond_to :products
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
      merchant = merchants(:ada)
      merchant.must_respond_to :orders
      merchant.orders.each do |order|
        order.must_be_kind_of Order
      end
    end

    it "has a list of order products" do
      order_product = merchants(:ada)
      order_product.must_respond_to :order_products
    end
  end
  describe "self.by_auth_hash(auth_hash)" do
    it "has an instance of merchant" do
      auth_hash = {
        'provider' => "github",
        'uid' => "12345",
        'info' => {'email' => "somebody@somesite.com",
          'nickname' => "Somebody"}
        }
        merchant_auth = Merchant.by_auth_hash auth_hash
        merchant_auth.must_be_kind_of Merchant
        # merchant_auth.must_respond_to
        # binding.pry
      end

      it "responds to the proper keys" do
        auth_hash = {
          'provider' => "github",
          'uid' => "12345",
          'info' => {'email' => "somebody@somesite.com",
            'nickname' => "Somebody"}
          }
          merchant_auth = Merchant.by_auth_hash auth_hash
          merchant_auth.must_respond_to :oauth_provider
          merchant_auth.must_respond_to :oauth_uid
          merchant_auth.must_respond_to :email
          merchant_auth.must_respond_to :username
          # binding.pry
        end

        it "has the correct values for merchant from auth_hash" do
          auth_hash = {
            'provider' => "github",
            'uid' => "12345",
            'info' => {'email' => "somebody@somesite.com",
              'nickname' => "Somebody"}
            }
            merchant_auth = Merchant.by_auth_hash auth_hash
            merchant_auth.oauth_provider.must_equal "github"
            merchant_auth.oauth_uid.must_equal "12345"
            merchant_auth.email.must_equal "somebody@somesite.com"
            merchant_auth.username.must_equal "Somebody"
          end

        end
      end
