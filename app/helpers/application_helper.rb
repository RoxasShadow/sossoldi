module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def humanize_date(date)
    if date.today?
      :today
    elsif (date + 1.day).today?
      :yesterday
    elsif date == date.prev_week
      :last_week
    else
      date.readable_inspect
    end
  end

  def percentage_variation(from, to)
    from ||= 0
    to   ||= 1
    
    (from - to) / to * 100
  end

  def force_sign_for(n)
    n > 0 ? "+#{n}" : n.to_s
  end
end
