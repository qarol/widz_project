class LectureUnit < ActiveRecord::Base
  belongs_to :lecture
  has_many :attendances

  def self.last_monday date=nil
    date ||= Date.today
    date.wday == 0 ? date - 6 : date - date.wday + 1
  end

  def self.previous_monday date=nil
    date ||= Date.today
    self.last_monday(self.last_monday(date) - 1)
  end

  def self.next_monday date=nil
    date ||= Date.today
    self.last_monday(self.last_monday(date) + 7)
  end
end
