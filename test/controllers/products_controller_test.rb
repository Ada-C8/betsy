require "test_helper"

describe ProductsController do
  let(:prod) { products(:mermaid_fin) }
  let(:good_params) { { product: { "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test" } } }
  let(:bad_params) { { product: { "name"=>"" } } }
  let(:tmi_params) { { product: { "name"=>"New Test Item", "price"=>"11.00", "quantity"=>"1", "description"=>"This is a test", "tmi"=>"uh oh", "id"=>1 } } }
  let(:new_params) { { product: { "name"=>"Updated Name" } } }
  let(:owned_product) { owned_product = Product.find_by(merchant_id: merchants(:ada).id) }
  let(:not_owned_product) { not_owned_product = Product.find_by(merchant_id: merchants(:grace).id) }

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
        get category_products_path(Category.first.id)

        controller.instance_variables.must_include :@cat
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
      it 'can successfully access edit for own product' do
        get edit_product_path(owned_product.id)

        must_respond_with :success
      end

      it 'CANNOT successfully access edit for not found product (returns not found)' do
        get edit_product_path(Product.last.id + 1)

        must_respond_with :not_found
      end

      it 'CANNOT successfully edit other users products' do
        get edit_product_path(not_owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe 'update' do
      it 'can successfully update own product & redirect to product show page with valid data' do
        patch product_path(owned_product.id), params: new_params, headers: { "HTTP_REFERER" => edit_product_path(owned_product.id) }
        id = owned_product.id

        Product.find(id).name.must_equal "Updated Name"
        flash[:status].must_equal :success
        must_redirect_to product_path
        must_respond_with :found
      end

      it 'redirects to inventory path if coming from inventory management page' do
        patch product_path(owned_product.id), params: new_params, headers: { "HTTP_REFERER" => self_inventory_path }
        id = owned_product.id

        Product.find(id).name.must_equal "Updated Name"
        flash[:status].must_equal :success
        must_redirect_to self_inventory_path
        must_respond_with :found
      end

      it 'CANNOT successfully update own product with invalid data' do
        patch product_path(owned_product.id), params: bad_params

        must_respond_with :bad_request
        flash[:status].must_equal :failure
      end

      it 'CANNOT successfully update other users product' do
        patch product_path(not_owned_product.id), params: new_params

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe 'destroy' do
      it 'can successfully destroy own product' do
        delete product_path(owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :success
        Product.count.must_equal (@before_count - 1)
      end

      it 'CANNOT destroy other users products' do
        delete product_path(not_owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :failure
        Product.count.must_equal @before_count
      end
    end

    describe 'categories' do
      it 'can access page for own products' do
        get add_categories_path(owned_product.id)

        must_respond_with :success
      end

      it 'CANNOT access page for other users products' do
        get add_categories_path(not_owned_product.id)

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe 'add_categories' do
      it 'can successfully add valid categories to own products' do
        cat_id = categories(:magic).id
        test_params = {
          id: owned_product.id,
          "category_Magic Items" => cat_id,
        }
        before_count = owned_product.categories.count

        post add_categories_path(owned_product.id), params: test_params

        must_respond_with :found
        flash[:status].must_equal :success
        owned_product.categories.count.must_equal (before_count + 1)
      end

      it 'CANNOT add invalid categories to own products' do
        cat_id = categories(:magic).id
        test_params = {
          id: owned_product.id,
          "category_bad_id" => (Category.last.id + 1),
        }

        before_count = owned_product.categories.count
        post add_categories_path(owned_product.id), params: test_params

        must_respond_with :found
        flash[:status].must_equal :failure
        owned_product.categories.count.must_equal before_count
      end

      it 'CANNOT successfully add categories to other users products' do
        test_params = { "product_id"=>"2",
          "category_Magic Items"=>"5",
          id: :id
        }

        post add_categories_path(not_owned_product.id), params: test_params

        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end
  end

  describe 'for guest users' do
    describe 'index' do
      it 'can successfully access index of products' do
        get products_path

        must_respond_with :success
      end

      it 'can successfully access nested index of products with valid id' do
        get category_products_path(Category.first.id)

        controller.instance_variables.must_include :@cat
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

    it 'CANNOT create valid product' do
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

    it 'CANNOT access add categories page' do
      get add_categories_path(owned_product.id)

      must_respond_with :found
      flash[:status].must_equal :failure
    end
  end
end
