class Classroom < ActiveRecord::Base
  belongs_to :educator, :class_name => "User", :foreign_key => :user_id
  has_many :classroom_users
  has_many :users, :through => :classroom_users
  has_many :subjects, :as => :team

  delegate :name, :lastname, :to => :educator, :prefix => true, :allow_nil => true

  named_scope :choose_year, lambda { |year_ago| { :conditions => ['year = ?', only_current_year - year_ago] }}

  validates_uniqueness_of :name_of_class, :scope => :year

  def students
    self.users.select{|u| u.is_student?}
  end

  def school_year
    self.year.to_s + "/" + (self.year+1).to_s
  end

  def current_year semester_id
    semester_year ||= Semester.choosen_or_current(semester_id).year
    result = semester_year - self.year + 1
    if result < 0
      0
    elsif result > 3
      3
    else
      result
    end
  end

  private
  def self.only_current_year
    Date.today.year + (Date.today < Date.new(Date.today.year, 9, 1) ? 0 : 1)
  end

end
