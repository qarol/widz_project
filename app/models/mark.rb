class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_mark

  named_scope :find_by_user_id, lambda { |user_id| { :conditions => { :user_id => user_id } } }

  delegate :weight, :to => :event_mark
end
