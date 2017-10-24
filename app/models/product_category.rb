class ProductCategory < ApplicationRecord
  # relationships
  belongs_to :product
  belongs_to :category
  
  # validations
  validates_uniqueness_of :product_id, :scope => :category_id

  def self.create_prod_cat(product)
    new_pc = ProductCategory.new(product_id: product[:product_id], category_id: product[:category_id])
    if new_pc.save
      return
    else
      flash[:status] = :failure
      flash[:message] = "There was a problem!"
      flash[:errors] = new_product_cat.errors.messages
      redirect_to new_product_path
    end
  end
end