module ApplicationHelper

  def money(float)
    "$%.2f" % float
  end

  def days_ago(date)
    (Date.today - date.to_date).to_i
  end
end
