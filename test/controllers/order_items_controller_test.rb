require "test_helper"

describe OrderItemsController do
  let(:chocolate1) { order_items(:orderitem1) }
  let(:soap2) { order_items(:orderitem2)}

  describe "OrderItem#update" do

    it "allows order_item updates for an order with an 'incomplete' status" do
    #Arrange
      chocolate1.order.status.must_equal "incomplete"
      new_quantity = 3
      oi_update_data = {
        order_item: {
          quantity: new_quantity,
          product: chocolate1.product,
          order: chocolate1.order
        }
      }

    #Action
      patch order_item_path(chocolate1.id), params: oi_update_data

    #Assert
      must_respond_with :redirect
      must_redirect_to order_path(chocolate1.order.id)

      OrderItem.find(chocolate1.id).quantity.must_equal new_quantity

    end

    it "does not allow you to choose a product quantity greater than the number available" do
      product = chocolate1.product
      original_quantity= chocolate1.quantity

      oi_update_data = {
        order_item: {
          quantity: (product.quantity + 1),
          product: chocolate1.product,
          order: chocolate1.order
        }
      }

      #Action
        patch order_item_path(chocolate1.id), params: oi_update_data

      #Assert
        must_respond_with :bad_request

        OrderItem.find(chocolate1.id).quantity.must_equal original_quantity

    end

    it "does not allow you to choose a product quantity greater than 20 or the number available" do

    end

    it "must have a valid quantity to update" do

      invalid = [-1,0]
      original_quantity= chocolate1.quantity

      invalid.each do |num|

        oi_update_data = {
          order_item: {
            quantity: num,
            product: chocolate1.product,
            order: chocolate1.order
          }
        }

        patch order_item_path(chocolate1.id), params: oi_update_data

        must_respond_with :bad_request
        OrderItem.find(chocolate1.id).quantity.must_equal original_quantity
      end

    end

    it "does not allow order_item updates for an order with a 'paid' status" do
    #Arrange
      soap2.order.status.must_equal "paid"

      old_quantity = soap2.quantity
      new_quantity = 3
      oi_update_data = {
        order_item: {
          quantity: new_quantity,
          product: soap2.product,
          order: soap2.order
        }
      }
    #Action

      patch order_item_path(soap2.id), params: oi_update_data

    #Assert

      must_respond_with :redirect

      OrderItem.find_by_id(soap2.id).quantity.must_equal old_quantity

    end

  end

  describe "OrderItem#destroy" do
    let(:incomplete) {orders(:pending_order)}
    let(:paid) { orders(:paid_order) }

    let(:chocolate1) { order_items(:orderitem1) }
    let(:soap2) { order_items(:orderitem2) }


    it "only deletes an order_item from cart when order status is incomplete" do
      #Arrange
      chocolate1.order.status.must_equal "incomplete"
      #Action
      delete order_item_path(chocolate1.id)
      #Assert
      OrderItem.find_by(id: chocolate1.id).must_be_nil
      must_redirect_to order_path(incomplete.id)

    end

    it "cannot delete an order_item from cart when order status is paid" do
      #Arrange
      soap2.order.status.must_equal "paid"
      #Action
      delete order_item_path(soap2.id)
      #Assert
      OrderItem.find_by(id: soap2.id).must_equal soap2
      must_redirect_to order_path(paid.id)

    end

  end
end
