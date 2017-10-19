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

    it "succeeds when there are no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "works" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new product" do
      # post products_path, params: {product: {name: "creepy things", quantity_avail: 4, price: 9.99, merchant_id: merchants(:spooky)}}
      # must_respond_with :redirect
      # must_redirect_to product_path(Product.last.id)

      # proc   {
      #   post products_path, params: {product: {name: "creepy things", quantity_avail: 4, price: 9.99, merchant: merchants(:witch)}}
      # }.must_change 'Category.count', 1
    end
  end

  describe "show" do
    it "succeeds for an existing product" do
      get product_path(Product.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus product ID" do
      fake = Product.last.id + 1
      get product_path(fake)
      must_respond_with :not_found
    end
  end
  #
  describe "edit" do
    #This wasn't in the controller actions.  Do we want an edit method?
  end

  describe "#add_product_to_cart" do
    setup { session_setup }
    it "should add the product to the pending" do
      #  Order.create
      # controller.session[:order_id] = order.id

      patch add_product_path(products(:pointy_hat).id)
      must_respond_with :redirect
    end

      # describe "update" do
      #   #This wasn't in the controller actions.  Do we want an edit method?
      # end

      describe "delete" do
        it "should successfully delete product" do
          delete product_path(products(:pointy_hat).id)
          must_respond_with :redirect
          must_redirect_to products_path

          proc   {
            delete product_path(products(:out_of_stock).id)
          }.must_change 'Product.count', -1
        end

        it "renders 404 not_found and does not update the DB for a bogus product ID" do
          start_count = Product.count

          bad = Product.last.id + 1
          delete product_path(bad)
          must_respond_with :not_found

          Product.count.must_equal start_count

        end
      end
    end
  end
