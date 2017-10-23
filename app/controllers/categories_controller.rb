class CategoriesController < ApplicationController
  before_action :confirm_login
  before_action :find_product_by_params, only: [:add]


    def create
      category = Category.new(name: params[:category_name])
      result = category.save

      if result
        flash[:status] = :success
        flash[:message] = "Added category #{category.name}"
        return redirect_to add_categories_path(params[:product_id])
      else
        flash[:status] = :failure
        flash[:message] = "Could not create new category"
        flash[:details] = category.errors.messages
        return redirect_to add_categories_path(params[:product_id])
      end
    end

    def add
      @categories = Category.all
    end
end
