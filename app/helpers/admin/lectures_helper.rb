module Admin::LecturesHelper
  def day_of_week day_number
    case day_number
    when 1
      "Poniedziałek"
    when 2
      "Wtorek"
    when 3
      "Środa"
    when 4
      "Czwartek"
    when 5
      "Piątek"
    when 6
      "Sobota"
    when 7
      "Niedziela"
    end
  end
end
