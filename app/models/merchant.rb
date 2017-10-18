class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true
end
