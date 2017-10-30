require "test_helper"

describe User do

  let(:existing_user) { users(:amy)}

  describe "relations" do
    it "has a list of reviews" do
      existing_user.must_respond_to :reviews
      existing_user.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end

    it "has a list of products" do
      existing_user.must_respond_to :products
      existing_user.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end

  describe "validations" do
    it "requires a uid" do
      user = User.new(email: "newuser@ada.com", provider: "github")
      user.valid?.must_equal false
      user.errors.messages.must_include :uid
    end

    it "creates new user with valid (unique) uid info" do
      valid_user = User.new(uid: 11112222, email: 'newuser@ada.com', provider: "github")
      valid_user.valid?.must_equal true
    end

    it "rejects new user with non-unique uid" do
      valid_user = User.new(uid: existing_user.uid, email: "newuser2@ada.com", provider: "github")
      valid_user.valid?.must_equal false
    end

    it "requires an email" do
      user = User.new(uid: 11112222, provider: "github")
      user.valid?.must_equal false
      user.errors.messages.must_include :email
    end

    it "creates new user with valid (unique) email" do
      valid_user = User.new(uid: 11112222, email: 'newuser@ada.com', provider: "github")
      valid_user.valid?.must_equal true
    end

    it "rejects new user with non-unique email" do
      valid_user = User.new(uid: 11112222, email: existing_user.email, provider: "github")
      valid_user.valid?.must_equal false
    end

    it "requires a provider" do
      user = User.new(uid:11112222, email: "newuser@ada.com")
      user.valid?.must_equal false
      user.errors.messages.must_include :provider
    end

    it "creates new user with valid provider (github) info" do
      valid_provider = ['github']

      valid_provider.each do |provider|
        valid_user = User.new(uid: 11112222, email: 'newuser@ada.com', provider: provider)
        valid_user.valid?.must_equal true
      end
    end

    it "rejects new user with invalid provider info" do
      invalid_provider = [nil, "", 'gmail', 12, -0.5, "githublogin"]

      invalid_provider.each do |provider|
        invalid_user = User.new(uid: 11112222, email: 'newuser@ada.com', provider: provider)
        invalid_user.valid?.must_equal false
        invalid_user.errors.messages.must_include :provider
      end
    end

  end

  describe "custom model methods" do
    let(:user) {users(:tanja)}
    let(:order_item) {order_items(:orderitem2)}
    let(:pending_order_item) {order_items(:orderitem1)}
    let(:status) {"paid"}
    let(:buttercup) {users(:buttercup)}

    describe "total_revenue_by_status" do

      it "returns a float" do
        user.total_revenue_by_status(status).must_be_kind_of BigDecimal
      end

      it "returns a correct value for paid order" do
        user.total_revenue_by_status(status).must_equal order_item.product.price * order_item.quantity
      end

      it "doesn't crash if user has no order items" do
        newuser = User.new(name: "Bob")
        newuser.must_respond_to :total_revenue_by_status
      end

      it "calculates revenue for zero value" do
        newuser = User.new(name: "Bob")
        newuser.total_revenue_by_status(status).must_equal 0.0
      end

      it "returns correct value for incomplete order" do
        user.total_revenue_by_status("incomplete").must_equal pending_order_item.product.price * pending_order_item.quantity
      end

    end

    describe "total_revenue" do
      it "returns the correct value" do
        user.total_revenue.must_equal user.total_revenue_by_status("paid") + user.total_revenue_by_status("incomplete")
      end
    end

    describe "user_orders" do
      it "returns an array of order items" do
        user.user_orders.must_be_kind_of Array
        user.user_orders.each do |order|
          order.must_be_kind_of Order
        end
      end

      it "returns an empty array if user has no orders" do
        buttercup.user_orders.must_be_kind_of Array
        buttercup.user_orders.count.must_equal 0
      end

      it "returns the correct value" do
        user.user_orders.count.must_equal 2
      end

    end
  end

end
