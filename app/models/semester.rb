class Semester < ActiveRecord::Base
  validates_uniqueness_of :year, :scope => :semester
  
  validate :start_date_before_end_date
  validate :years_and_selected_school_year_are_correct
  validate :max_1_choosen_semester

  has_many :classrooms, :foreign_key => 'year', :primary_key => 'year'
  has_many :groups
  has_many :subjects
  has_many :groups

  def self.choosen
    Semester.find(:first, :conditions => { :active => true })
  end

  def self.current
    Semester.find(:first, :conditions => [ 'start <= ? AND end >= ?', Date.today.to_s, Date.today.to_s ])
  end

  def self.choosen_or_current semester_id
    Semester.find_by_id(semester_id) || self.current
  end

  def next
    Semester.find_by_semester(self.semester%2+1, :conditions => { :year => self.year+(self.semester+1)%2 })
  end
  def previous
    Semester.find_by_semester(self.semester%2+1, :conditions => { :year => self.year-(self.semester%2) })
  end

  def self.choosen_or_current_next semester_id
    sem = self.choosen_or_current semester_id
    Semester.find_by_semester(sem.semester%2+1, :conditions => { :year => sem.year+(sem.semester+1)%2 })
  end
  def self.choosen_or_current_previous semester_id
    sem = self.choosen_or_current semester_id
    Semester.find_by_semester(sem.semester%2+1, :conditions => { :year => sem.year-(sem.semester%2) })
  end

  def classrooms_of_year null=true, year=nil
    result = []
    if year.nil?
      result = [Classroom.find(:all, :conditions => [ 'year = ?', self.year + 1 ], :order => 'name_of_class ASC')] if null
      result += (1..3).to_a.map{|n| Classroom.find(:all, :conditions => [ 'year = ?', self.year + 1 - n ], :order => 'name_of_class ASC')}
    else
      Classroom.find(:all, :conditions => [ 'year = ?', self.year + 1 - year ], :order => 'name_of_class ASC')
    end
  end

  def school_year
    self.year.to_s + "/" + (self.year+1).to_s
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
  def year_and_semester
    self.school_year + " " + self.h_semester
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
