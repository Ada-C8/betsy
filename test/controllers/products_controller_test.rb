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
    let(:merchant) { merchants(:ada) }

    it "creates a new product" do
      merchant = merchants(:ada)
      login(merchant)
      proc   {
        post products_path, params: { product: { name: "eyeballs", quantity_avail: 4, price: 9.99}, merchant_id: merchant.id}
      }.must_change 'Product.count', 1
    end

    it "fails when missing params" do
      merchant = merchants(:ada)
      login(merchant)
      proc   {
        post products_path, params: { product: { name: "", quantity_avail: 4, price: 9.99}, merchant_id: merchant.id}
      }.must_change 'Product.count', 0
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
    it "succeeds for an existing product" do
      get edit_product_path(Product.first)
      must_respond_with :success
    end

  end

  describe "#add_product_to_cart" do
    setup { session_setup }

    it "should add in-stock products to the pending order" do
      patch add_product_path(products(:pointy_hat).id)
      must_respond_with :redirect

    end

    it "should not add out-of-stock products to pending order" do
      patch add_product_path(products(:out_of_stock).id)
      must_respond_with :redirect

    end

    it "can add the same product multiple times when in stock" do
      patch add_product_path(products(:pointy_hat).id)
      patch add_product_path(products(:pointy_hat).id)

      order = Order.find_by(id: session[:order_id])
      order.products.size.must_equal 2

      order.products.each do |prod|
        prod.name.must_equal "Pointy Hat"
      end
    end

    it "changes the product quantity if successful" do
      product = products(:pointy_hat)
      product.quantity_avail.must_equal 5

      patch add_product_path(product.id)
      patch add_product_path(product.id)


      Product.find(products(:pointy_hat).id).quantity_avail.must_equal 3
    end

  end

  describe "remove_product_from_cart" do
    setup { session_setup }

    before do
      patch add_product_path(products(:pointy_hat).id)
      patch add_product_path(products(:pointy_hat).id)
      @order = Order.find_by(id: session[:order_id])
    end

    it "should remove exactly one instance of product from the order if at least one instance is in order" do
      @order.products.size.must_equal 2

      patch remove_product_path(products(:pointy_hat).id)
      @order.products.size.must_equal 1
    end

    it "adds one product back to quantity_avail if successfully removed from order" do
      Product.find(products(:pointy_hat).id).quantity_avail.must_equal 3

      patch remove_product_path(products(:pointy_hat).id)

      Product.find(products(:pointy_hat).id).quantity_avail.must_equal 4

    end

    it "should not change order.products if product not there" do
      patch remove_product_path(products(:not_in_order).id)
      @order.products.size.must_equal 2

    end

    it "should not change quantity of product available if not successful" do
      Product.find(products(:not_in_order).id).quantity_avail.must_equal 5

      patch remove_product_path(products(:not_in_order).id)

      Product.find(products(:not_in_order).id).quantity_avail.must_equal 5
    end


  end


  describe "update" do
    let(:merchant) { merchants(:ada) }
    it "update an existant product" do
      merchant = merchants(:ada)
      login(merchant)
      product = Product.find(products(:invisible_hat).id)
      product_data = {
        product: {
          name: product.name + "more text"
        }
      }

      patch product_path(product), params: product_data
      must_redirect_to merchant_products_path(session[:user_id])


      Product.find(product.id).name.must_equal product_data[:product][:name]
    end
  end

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

  describe "product by category" do
    it "should get products by category" do
      get category_products_path(categories(:brooms).id)
      must_respond_with :success
    end

    it "should render 404 if category does not exist" do
      bad = Category.last.id + 1
      get category_products_path(bad)
      must_respond_with :not_found
    end
  end

  describe "products by merchant" do
    it "should show products belonging to a specific merchant" do
      get merchant_products_path(merchants(:witch).id)
      must_respond_with :success
    end

    it "should render 404 if merchant does not exist" do
      bad = Merchant.last.id + 1
      get merchant_products_path(bad)
      must_respond_with :not_found
    end
  end

end
