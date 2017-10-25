module ApplicationHelper

  def money(float, small = false)
    if small
      length = float.to_s.length
      if length > 9
        return "$%.1fm" % (float / 1000000)
      elsif length > 6
        return "$%.1fk" % (float / 1000)
      end
    end
      return "$%.2f" % float
  end

  def days_ago(date)
    (Date.today - date.to_date).to_i
  end
end
