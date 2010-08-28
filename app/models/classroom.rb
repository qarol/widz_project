class Classroom < ActiveRecord::Base
  belongs_to :educator, :class_name => "User" # wychowawca
  has_many :classroom_users
  has_many :users, :through => :classroom_users
end
