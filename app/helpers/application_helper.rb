module ApplicationHelper

  def money(float, small = false)
    if small
      length = float.to_s.length
      if length > 12
        return "$%.1f<small>b</small>".html_safe % (float / 1000000000)
      elsif length > 11
        return "<small>$%.1fm</small>".html_safe % (float / 1000000)
      elsif length > 9
        return "$%.1f<small>m</small>".html_safe % (float / 1000000)
      elsif length > 8
        return "<small>$%.1fk</small>".html_safe % (float / 1000)
      elsif length > 6
        return "$%.1f<small>k</small>".html_safe % (float / 1000)
      elsif length > 5
        return "$%.1i".html_safe % (float)
      end
    end
    return "$%.2f" % float
  end

  def days_ago(date)
    (Date.today - date.to_date).to_i
  end
end
