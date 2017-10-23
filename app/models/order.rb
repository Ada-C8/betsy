class Order < ApplicationRecord
  TAX = 0.101 # tax as a decimal

  belongs_to :user
  has_one :billing, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def price
    return order_items.sum { |order_item| order_item.price }
  end

  def tax
    return price * TAX
  end

  def total
    return price + tax
  end

  def change_status(new_status)
    # exit if new_status not valid
    return if !OrderItem::STATUSES.include? new_status

    # doesn't trigger validations
    OrderItem.where(order_id: id).update_all(status: new_status, updated_at: DateTime.now)
  end

  # clean this up??
  # updates and returns true if successful; else false
  def update_inventory
    # iterates through items once to confirm all inventory there before updating
    order_items.each do |item|
      inventory = item.product.quantity

      if inventory < item.quantity
        change_status("pending")
        return {name: item.product.name, qty: item.product.quantity}
      end
    end

    # confirm order_item status is paid
    order_items.each do |item|
      item.update_product_quantity
      # if item.status == "paid"
      #   item.product.quantity -= item.quantity
      #
      #   # if inventory update fails -- this shouldn't happen
      #   if !item.product.save
      #     order.errors.add(:order_item, message: "order couldn't save")
      #     return false
      #   end
      # end
    end

    return {}
  end

end
