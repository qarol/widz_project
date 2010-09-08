class Lecture < ActiveRecord::Base
  belongs_to :subject
  belongs_to :order_of_the_day

  validates_uniqueness_of :order_of_the_day_id, :scope => [:subject_id, :day_of_week]
  validates_uniqueness_of :day_of_week, :scope => [:subject_id, :order_of_the_day_id]

  delegate :subject_name_name, :to =>:subject, :allow_nil => true
  delegate :user_name, :user_lastname, :to => :subject, :allow_nil => true
end
