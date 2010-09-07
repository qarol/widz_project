class Semester < ActiveRecord::Base
  validates_uniqueness_of :year, :scope => :semester
  
  validate :start_date_before_end_date
  validate :years_and_selected_school_year_are_correct
  validate :max_1_choosen_semester

  def self.choosen_semester
    Semester.find(:first, :conditions => { :active => true })
  end

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

  def self.update_active active_id
    unless active_id.nil?
      Semester.all.each do |sem|
        sem.update_attributes(:active => false)
      end
      Semester.find(active_id).update_attributes(:active => true)
      true
    else
      false
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
  def max_1_choosen_semester
    active = Semester.find(:all, :conditions => { :active => true })
    errors.add_to_base("Może być w tym samym momencie wybrany maksymalnie jeden semestr") if active.size > 1
  end
end
