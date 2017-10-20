require "test_helper"

describe ProductsController do
  let(:p) { Product.first }

  before do
    before_count = Product.count
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
      skip
    end

    it 'can successfully create valid product' do
      skip
    end

    it 'can successfully access edit for own product' do
      skip
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
    end

    it 'CANNOT successfully create valid product' do
      skip
    end

    it 'CANNOT access edit for product' do
      skip
    end

    it 'CANNOT update product' do
      skip
    end

    it 'CANNOT destroy other users products' do
      skip
    end
  end
end
