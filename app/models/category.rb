class Category < ApplicationRecord
  # validates :category_name, uniqueness: true,

  has_many :products

  validates :category_name, presence: true, uniqueness: true, length: { maximum: 30, too_long: "Name must be shorter than 30 characters." }
  # must have category_name, must be unique
end
