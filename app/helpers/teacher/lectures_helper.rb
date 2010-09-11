module Teacher::LecturesHelper
  def short_day_month date
    date.strftime("%d.%m")
  end
end
