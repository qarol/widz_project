class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :subjects, :as => :team
  belongs_to :semester

  delegate :year, :to => :semester, :prefix => false, :allow_nil => true
end
