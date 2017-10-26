class Order < ApplicationRecord
  VALID_STATS = ["pending", "complete", "shipped"]
  has_and_belongs_to_many :products
  validates :status, presence: true, inclusion: { in: VALID_STATS }
  validates :name, presence: true, if: :completed?
  validates :address, presence: true, if: :completed?
  validates :city, presence: true, if: :completed?
  validates :state, presence: true, if: :completed?
  validates :email, presence: true, if: :completed?, format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }
  validates :card_number, presence: true, if: :completed?, numericality: true, length: {is: 16}
  validates :card_exp, presence: true, if: :completed?
  validates :card_cvv, presence: true, if: :completed?, numericality: true, length: {is: 3}
  validates :zip_code, presence: true, if: :completed?, format: { with: /\A\d{5}-\d{4}|\A\d{5}\z/ }

  attribute :status, :string, default: "pending"

  def completed?
    self.status == "complete"
  end

  def shipped
    self.status == "shipped"
  end

  def order_total
    total = 0
    self.products.each do |product|
      total += product.price
    end
    return total

  end

  def last_four
    cc_last = self.card_number.slice(10..-1)
    return cc_last
  end

end
