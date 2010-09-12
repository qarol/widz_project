class EventMark < ActiveRecord::Base
  belongs_to :subject
  has_many :marks

  validates_numericality_of :weight, :only_integer => true
  validates_presence_of :content

  accepts_nested_attributes_for :marks
end
