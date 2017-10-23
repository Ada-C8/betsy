class Product < ApplicationRecord
  has_many :reviews
  has_many :items
  belongs_to :user
  # add through: to associate join table
  has_and_belongs_to_many :categories, through: :categories_products
  validates :user_id, presence: true
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  # validates :category_id, presence: true
  validates :price, numericality: true
  validates :visibility, inclusion: {in: [true,false]}


  def self.show_available
    Product.where(visibility: true)
  end
end
