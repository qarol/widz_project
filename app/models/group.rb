class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_one :subject, :as => :team, :dependent => :destroy
  belongs_to :semester

  delegate :year, :to => :semester, :prefix => false, :allow_nil => true
  delegate :school_year, :h_semester, :to => :semester, :prefix => true, :allow_nil => true

  accepts_nested_attributes_for :subject

  def user
    self.subject.user unless self.subject.nil?
  end
end
