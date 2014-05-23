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

  def numeric?(n)
    n.to_i.to_s == n || n.to_f.to_s == n
  end

  def normalize_month(month)
    month = case month.to_sym
      when :this_month         then Date.today.month
      when :the_last_month     then Date.today.month - 1
      when :the_previous_month then Date.today.month - 1
      else month.to_s
    end

    if month.is_a? String
      numeric?(month) ? month.to_i : Date::MONTHNAMES.index(month.capitalize)
    else
      month
    end
  end

  def next_month(month)
    month = normalize_month month
    month == 12 ? 1 : month + 1
  end
end
