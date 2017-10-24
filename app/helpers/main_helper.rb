module MainHelper
  def total(array)
    array.sum { |n| n.total }
  end
end
