require "test_helper"

describe ProductsController do

  describe 'root path' do
    it "successfully navigates to root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe 'index' do
    it "succeeds when there are products" do
      get products_path
      must_respond_with :success
    end
  end

  describe "#add_product_to_cart" do
    setup { session_setup }
    it "should add the product to the pending" do
      #  Order.create
      # controller.session[:order_id] = order.id

      patch add_product_path(products(:pointy_hat).id)
      must_respond_with :redirect
    end
  end

end
