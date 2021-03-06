class Subject < ActiveRecord::Base
  belongs_to :semester
  belongs_to :user
  belongs_to :team, :polymorphic => true
  belongs_to :subject_name
  has_many :lectures
  has_many :event_marks

  delegate :name, :to => :subject_name, :prefix => true, :allow_nil => true
  delegate :year, :school_year, :h_semester, :to => :semester, :prefix => true, :allow_nil => true
  delegate :name, :lastname, :to => :user, :prefix => true, :allow_nil => true

  validates_presence_of :subject_name_id
  validates_presence_of :semester_id
  validates_presence_of :user_id
  validates_presence_of :team

  named_scope :semester, lambda { |semester_id| { :conditions => { :semester_id => semester_id }}}

  def team_type_id
    self.team_type + "_" + self.team_id.to_s
  end
end
