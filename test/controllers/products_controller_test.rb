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

  describe 'create' do

  end
end
