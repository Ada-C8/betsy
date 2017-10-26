require "test_helper"

describe MainController do
  let(:wand) { products(:wand) }

  it 'can successfully access the index page' do
    get root_path

    must_respond_with :success
  end

  describe '#add_to_cart' do
    it 'adds items to cart' do
      params = {
        "quantity" => "4",
        "id" => wand.id
      }

      get add_to_cart_path(wand.id), params: params

      binding.pry

      must_respond_with :success
      flash[:status].must_equal :success
    end
  end
end
