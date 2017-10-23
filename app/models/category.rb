class Category < ApplicationRecord
  has_many :products

  validates :category_name, presence: true, uniqueness: true
  # must have category_name, must be unique
end
