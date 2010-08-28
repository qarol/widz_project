class Classroom < ActiveRecord::Base
  has_many :classroom_users
  has_many :users, :through => :classroom_users
end
