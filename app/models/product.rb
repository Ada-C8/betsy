class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders

end
