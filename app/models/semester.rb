class Semester < ActiveRecord::Base
  validates_uniqueness_of :year, :scope => :semester
  
  validate :start_date_before_end_date
  validate :years_and_selected_school_year_are_correct

  def h_semester
    case self.semester
    when 1
      "zimowy"
    when 2
      "letni"
    else
      "nieokreślony"
    end
  end

  private
  def start_date_before_end_date
    errors.add_to_base("Data końca semestru jest mniejsza od daty początku") if self.end < self.start
  end
  def years_and_selected_school_year_are_correct
    errors.add_to_base("Data początku semestru nie zawiera się w wybranym roku szkolnym") unless [self.year, self.year+1].include?(self.start.year)
    errors.add_to_base("Data końca semestru nie zawiera się w wybranym roku szkolnym") unless [self.year, self.year+1].include?(self.end.year)
  end
end
