class Category < ApplicationRecord
  # validates :category_name, uniqueness: true, length: { maximum: 30, too_long: "%{30} characters is the maximum allowed" }
  
  has_many :products
end
