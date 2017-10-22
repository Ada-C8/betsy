require "test_helper"

describe Product do
  let(:product) { products(:mermaid_fin) }

  describe 'validations' do
    it 'accepts valid data' do
      product.must_be :valid?
    end

    describe 'name' do
      it 'requires name to be present' do
        product.name = nil

        product.wont_be :valid?
        product.errors.messages.must_include :name
      end

      it 'requires name to be unique' do
        prod2 = Product.new(
          name: 'Mermaid Fin',
          price: 1.11,
          quantity: 10,
          merchant_id: merchants(:grace).id
        )

        prod2.wont_be :valid?
        prod2.errors.messages.must_include :name
      end
    end

    describe 'price' do
      it 'requires price to be present' do
        product.price = nil

        product.wont_be :valid?
        product.errors.messages.must_include :price
      end

      it 'requires price to be a number greater than 0' do
        # Rails automatically converts most invalid inputs to 0. This input would not be accepted.
        # Potential issues: 'true' converts to 1
        # Does this require a custom validation? Is there a scenario in which a user could accidentally enter 'true'?
        [-15, 'hey', false, nil, 0].each do |value|
          product.price = value

          product.wont_be :valid?
          product.errors.messages.must_include :price
        end
      end
    end

    describe 'quantity' do
      it 'requires quantity to be present' do
        product.quantity = nil

        product.wont_be :valid?
        product.errors.messages.must_include :quantity
      end

      it 'requires quantity to be an integer greater than or equal to 0' do
        # Rails automatically converts most invalid inputs to 0. An item won't display with a quantity of 0, but it will save, which isn't ideal.
        # Other potential issues: 'true' converts to 1, any float is just rounded down
        # Does this require a custom validation?
        product.quantity = -1

        product.wont_be :valid?
        product.errors.messages.must_include :quantity
      end
    end
  end

  describe 'relationships' do
    it 'has order_products' do
      product.must_respond_to :order_products
      product.order_products.each do |op|
        op.must_be_kind_of OrderProduct
      end
    end

    it 'has reviews' do
      product.must_respond_to :reviews
      product.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end

    it 'has orders' do
      product.must_respond_to :orders
      product.orders do |order|
        order.must_be_kind_of Order
      end
    end

    it 'has merchant' do
      product.must_respond_to :merchant
      product.merchant.must_be_kind_of Merchant
    end
  end

  describe 'most_popular' do
    it 'returns an array of 6 products if database contains at least 6 products' do
      1..6.times do |i|
        Product.create!(name: i, price: i+1, quantity: i, merchant_id: Merchant.first.id)
      end
      prods = Product.most_popular

      prods.length.must_equal 6
    end

    it 'returns a shorter array of products if database less than 6 products' do
      if Product.count >= 6
        i = Product.count
        until i < 6
          Product.last.destroy
        end
      end
      prods = Product.most_popular

      prods.length.must_equal Product.count
    end

    it 'orders array by number of orders for product' do
      prods = Product.most_popular
      prods.each_cons(2) do |pair|
        (pair[0].orders.count >= pair[1].orders.count).must_equal true
      end
    end

    it 'returns an empty array if database contains no products' do
      Product.destroy_all

      Product.most_popular.must_equal []
    end
  end

  describe 'add_categories_by_params' do
    it 'adds provided categories to product' do
      test_categories = [Category.first, Category.last]
      test_params = { 'category_test_0' => test_categories[0].id,
                      'category_test_1' => test_categories[1].id }

      product.add_categories_by_params(test_params)

      product.categories.must_include test_categories[0]
      product.categories.must_include test_categories[1]
    end

    it 'wont duplicate categories within product' do
      test_category = Category.first
      test_params = { 'category_test' => test_category.id }

      count = product.categories.count

      test_params = { 'category_test' => test_category.id }

      product.categories.count.must_equal count
    end
  end
end
