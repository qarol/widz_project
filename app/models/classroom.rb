class Classroom < ActiveRecord::Base
  belongs_to :educator, :class_name => "User", :foreign_key => :user_id
  has_many :classroom_users
  has_many :users, :through => :classroom_users

  delegate :name, :lastname, :to => :educator, :prefix => true, :allow_nil => true

  def students
    self.users.select{|u| u.is_student?}
  end
end
