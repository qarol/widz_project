class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :lecture_unit

  delegate :date, :to => :lecture_unit, :prefix => true, :allow_nil => true
end
