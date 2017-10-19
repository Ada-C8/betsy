class Product < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  has_many :orders


  validates :name, presence: true, uniqueness: { message: "That name is in use, please choose a different one." }

  validates :price, presence: true, numericality: { greater_than: 0 }

  # validates :merchant_id, presence: true
  #
  # validates :category_id, presence: true

  # validates_associated :merchant, :category

end
