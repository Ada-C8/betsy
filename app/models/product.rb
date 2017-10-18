class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity_avail, presence: true

  belongs_to :merchant
  has_many :reviews
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders

end
