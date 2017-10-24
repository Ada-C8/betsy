module ApplicationHelper

  def money(float)
    "$%.2f" % float
  end
end
