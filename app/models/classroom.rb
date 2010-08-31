class Classroom < ActiveRecord::Base
  belongs_to :educator, :class_name => "User", :foreign_key => :user_id
  has_many :classroom_users
  has_many :users, :through => :classroom_users

  delegate :name, :lastname, :to => :educator, :prefix => true, :allow_nil => true

  named_scope :choose_year, lambda { |year_ago| { :conditions => ['year = ?', only_current_year - year_ago] }}

  def students
    self.users.select{|u| u.is_student?}
  end

  def current_year
    Date.today.year - self.year + (Date.today < Date.new(Date.today.year, 9, 1) ? 0 : 1)
  end

  private
  def self.only_current_year
    Date.today.year + (Date.today < Date.new(Date.today.year, 9, 1) ? 0 : 1)
  end

end
