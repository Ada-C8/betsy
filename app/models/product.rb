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
    Product.all.sort_by{|p| -p.orders.count}[0...3]
  end


  def show_data
    puts params
    puts "controller"
  end

  def add_categories_by_params(params)
    new_categories = params.keep_if{|key, value| key.include?'category'}

    new_categories.values.each do |cat|
      category = Category.find(cat)
      self.categories << category
    end

    return self.save
  end

end
