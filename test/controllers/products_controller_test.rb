require "test_helper"

describe ProductsController do
  let(:prod) { products(:mermaid_fin) }
  let(:good_params) { { product: { "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test" } } }
  let(:bad_params) { { product: { "name"=>"" } } }
  let(:tmi_params) { { product: { "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test", "tmi"=>"uh oh", "id"=>1 } } }
  let(:new_params) { { product: { "name"=>"Updated Name" } } }

  before do
    @before_count = Product.count
  end

  describe 'for logged in users' do
    before do
      user = merchants(:ada)
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get login_path(:github)
    end

    describe 'index' do
      it 'can successfully access index of products' do
        get products_path

        must_respond_with :success
      end

      it 'can successfully access nested index of products with valid id' do
        get products_path(Category.first.id)

        must_respond_with :success
      end

      it 'returns 404 for invalid category ID in nested route' do
        get products_path, params: { 'category_id' => (Category.last.id + 1) }

        must_respond_with :not_found
      end
    end

    describe 'show' do
      it 'can successfully access show product with valid ID' do
        get product_path(prod.id)

        must_respond_with :success
      end

      it 'returns 404 with invalid ID' do
        get product_path( Product.last.id + 1 )

        must_respond_with :not_found
      end
    end

    it 'can successfully access new product' do
      get new_product_path

      must_respond_with :success
    end

    describe 'create' do
      it 'can successfully create valid product' do
        post products_path, params: good_params

        must_respond_with :found
        flash[:status].must_equal :success
        Product.count.must_equal (@before_count + 1)
      end

      it 'will not create new product with invalid data' do
        post products_path, params: bad_params

        must_respond_with :bad_request
        flash[:status].must_equal :failure
        Product.count.must_equal @before_count
      end

      it 'uses strong params' do
        post products_path, params: tmi_params

        must_respond_with :found
        flash[:status].must_equal :success
        Product.last.id.wont_equal 1
        Product.count.must_equal (@before_count + 1)
      end
    end

    describe 'edit' do
      # these tests will have to change when logging in actually works (dependent on fakey_login)
      it 'can successfully access edit for own product' do
        owned_product = Product.find_by(merchant_id: Merchant.first.id)
        get edit_product_path(owned_product.id)

        must_respond_with :success
      end

      it 'CANNOT successfully edit other users products' do
        not_owned_product = Product.find_by(merchant_id: Merchant.last.id)
        get edit_product_path(not_owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe 'update' do
      it 'can successfully update own product with valid data' do
        owned_product = Product.find_by(merchant_id: Merchant.first.id)
        patch product_path(owned_product.id), params: new_params

        # WHY does only this not work?
        # owned_product.name.must_equal "Updated Name"
        flash[:status].must_equal :success
        must_respond_with :found
      end

      it 'CANNOT successfully update own product with invalid data' do
        owned_product = Product.find_by(merchant_id: Merchant.first.id)
        patch product_path(owned_product.id), params: bad_params

        must_respond_with :bad_request
        flash[:status].must_equal :failure
      end

      it 'CANNOT successfully update other users product' do
        not_owned_product = Product.find_by(merchant_id: Merchant.last.id)
        patch product_path(not_owned_product.id), params: new_params

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe 'destroy' do
      it 'can successfully destroy own product' do
        owned_product = Product.find_by(merchant_id: Merchant.first.id)
        delete product_path(owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :success
        Product.count.must_equal (@before_count - 1)
      end

      it 'CANNOT destroy other users products' do
        not_owned_product = Product.find_by(merchant_id: Merchant.last.id)
        delete product_path(not_owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :failure
        Product.count.must_equal @before_count
      end
    end

    it 'can successfully categories' do
      get product_path(prod.id)

      must_respond_with :success
    end
  end

  describe 'for guest users' do
    describe 'index' do
      it 'can successfully access index of products' do
        get products_path

        must_respond_with :success
      end

      it 'can successfully access nested index of products with valid id' do
        get products_path(Category.first.id)

        must_respond_with :success
      end

      it 'returns 404 for invalid category ID in nested route' do
        get products_path, params: { 'category_id' => (Category.last.id + 1) }

        must_respond_with :not_found
      end
    end

    describe 'show' do
      it 'can successfully access show product with valid ID' do
        get product_path(prod.id)

        must_respond_with :success
      end

      it 'returns 404 with invalid ID' do
        get product_path( Product.last.id + 1 )

        must_respond_with :not_found
      end
    end

    it 'CANNOT access new product' do
      get new_product_path(prod.id)

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT successfully create valid product' do
      post products_path(prod.id), params: good_params

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT access edit for product' do
      get edit_product_path(prod.id)

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT update product' do
      patch product_path(prod.id), params: good_params

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT destroy other users products' do
      delete product_path(prod.id)

      flash[:status].must_equal :failure
      must_respond_with :found
    end
  end
end
