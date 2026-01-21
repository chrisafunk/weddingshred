module Admin::WeddingGroupsHelper
  def wedding_date_with_countdown(date)
    return "" unless date

    today = Date.current
    if date > today
      distance = distance_of_time_in_words(today, date, include_seconds: false)
      "#{date.strftime('%B %d, %Y')} (in #{distance})"
    else
      "#{date.strftime('%B %d, %Y')}"
    end
  end
end