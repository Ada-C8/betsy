require "test_helper"

describe MainController do
  let(:wand) { products(:wand) }

  it 'can successfully access the index page' do
    get root_path

    must_respond_with :success
  end

  it 'can successfully access the shopping cart page' do
    get shopping_cart_path

    must_respond_with :success
  end

  describe '#add_to_cart' do
    it 'adds items to cart' do
      params = {
        "quantity" => "4",
        "id" => wand.id
      }

      post add_to_cart_path(wand.id), params: params

      must_respond_with :found
      flash[:status].must_equal :success
      session[:cart].length.must_equal 1
    end

    it 'returns not_found for DNE product' do
      bad_id = Product.last.id + 1
      params = {
        "quantity" => "4",
        "id" => bad_id
      }

      post add_to_cart_path(bad_id), params: params

      must_respond_with :not_found
      session[:cart].length.must_equal 0
    end

    it 'wont work if no quantity is passed' do
      params = {
        "id" => wand.id
      }

      post add_to_cart_path(wand.id), params: params

      must_respond_with :found
      flash[:status].must_equal :failure

      session[:cart].length.must_equal 0
    end
  end
end
