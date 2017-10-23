require "test_helper"

describe CategoriesController do

  let(:params) {
    { "category_name" => "Test",
      "product_id" => Product.first.id
    }
  }

  describe 'create' do
    describe 'logged in users' do
      before do
        user = merchants(:ada)
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
        get login_path(:github)
      end

      it 'can be created by a logged-in user with valid data' do
        before_count = Category.count
        post categories_path, params: params

        must_respond_with :found
        flash[:status].must_equal :success
        Category.count.must_equal (before_count + 1)
      end

      it 'cannot be created by a logged-in user with invalid data' do
        params['category_name'] = ""
        before_count = Category.count
        post categories_path, params: params

        must_respond_with :found
        flash[:status].must_equal :failure
        Category.count.must_equal (before_count)
      end
    end

    describe 'guest users' do
      it 'cannot be created by a guest user' do
        before_count = Category.count
        post categories_path, params: params

        must_respond_with :found
        flash[:status].must_equal :failure
        Category.count.must_equal (before_count)
      end
    end
  end
end
