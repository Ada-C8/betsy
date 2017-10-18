class Order < ApplicationRecord
  VALID_STATS = ["pending", "complete"]
  has_and_belongs_to_many :products
  validates :status, presence: true, inclusion: { in: VALID_STATS }
end
