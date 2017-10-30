module ApplicationHelper
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def print_categories(product)
    to_print = []
    product.categories.each do |category|
      to_print << category.name.capitalize
    end
    return to_print.join(", ")
  end
end
