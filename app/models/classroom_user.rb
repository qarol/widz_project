class ClassroomUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :classroom
end
