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
end
