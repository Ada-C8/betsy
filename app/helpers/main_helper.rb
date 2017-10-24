module MainHelper
  def total(array)
    array.inject { |sum, n| sum + n.total }
  end
end
