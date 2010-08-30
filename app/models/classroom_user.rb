class ClassroomUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :classroom

  attr_accessible :user_id, :classroom_id

  validates_uniqueness_of :user_id, :scope => :classroom_id
  validates_uniqueness_of :classroom_id, :scope => :user_id
end
