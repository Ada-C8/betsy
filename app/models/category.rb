class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, :maximum => 25
end
