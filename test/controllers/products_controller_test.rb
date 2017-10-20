require "test_helper"

describe ProductsController do
  let(:p) { Product.first }
  let(:owned_product) { Product.find_by(merchant_id: Merchant.first.id) }
  let(:good_params) { { product: {
    "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test"}
  } }
  let(:bad_params) { { product: {
    "name"=>""}
  } }
  let(:tmi_params) { { product: {
    "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test", "tmi"=>"uh oh", "id"=>1}
  } }

  before do
    @before_count = Product.count
  end

  describe 'for logged in users' do
    before do
      # log in
    end

    it 'can successfully access index of products' do
      get products_path

      must_respond_with :success
    end

    it 'can successfully access show product' do
      get product_path(p.id)

      must_respond_with :success
    end

    it 'can successfully access new product' do
      # skip
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

    it 'can successfully access edit for own product' do
      get edit_product_path(p.id)

      must_respond_with :success
    end

    it 'CANNOT successfully edit other users products' do
      skip
    end

    it 'can successfully update own product' do
      skip
    end

    it 'CANNOT successfully update other users product' do
      skip
    end

    it 'can successfully destroy own product' do
      skip
    end

    it 'CANNOT destroy other users products' do
      skip
    end
  end

  describe 'for guest users' do
    it 'can successfully access index of products' do
      get products_path

      must_respond_with :success
    end

    it 'can successfully access show product' do
      get product_path(p.id)

      must_respond_with :success
    end

    it 'CANNOT access new product' do
      skip
      get new_product_path(p.id)

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT successfully create valid product' do
      skip
    end

    it 'CANNOT access edit for product' do
      skip
      get edit_product_path(owned_product.id)

      flash[:status].must_equal :failure
      must_respond_with :found
    end

    it 'CANNOT update product' do
      skip
    end

    it 'CANNOT destroy other users products' do
      skip
    end
  end
end
