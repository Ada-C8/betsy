class Order < ApplicationRecord
  VALID_STATS = ["pending", "complete"]
  has_and_belongs_to_many :products
  validates :status, presence: true, inclusion: { in: VALID_STATS }
  validates :email, presence: true, if: :completed?
  validates :address, presence: true, if: :completed?
  validates :name, presence: true, if: :completed?
  validates :card_number, presence: true, if: :completed?
  validates :card_exp, presence: true, if: :completed?
  validates :card_cvv, presence: true, if: :completed?
  validates :zip_code, presence: true, if: :completed?

  attribute :status, :string, default: "pending"

  def completed?
    self.status == "complete"
  end

  def order_total
    total = 0
    self.products.each do |product|
      total += product.price
    end
    return total

  end



end
