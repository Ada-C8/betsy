class Product < ApplicationRecord
  has_many :order_products
  has_many :reviews
  has_many :orders, through: :order_products
  belongs_to :merchant
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}

  def self.most_popular
    @products = Product.where.not(quantity: 0).sort_by { |prod| -prod.orders.count }[0...6]
  end

  def add_categories_by_params(params)
    new_categories = params.keep_if{|key, value| key.include?'category'}

    new_categories.values.each do |cat|
      category = Category.find_by(id: cat)
      if category.nil?
         errors.add(:categories, 'doesn\'t exist')
        return false
      end
      self.categories << category unless self.categories.include? category
    end

    return self.save
  end

end
