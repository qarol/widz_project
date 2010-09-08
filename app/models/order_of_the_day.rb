class OrderOfTheDay < ActiveRecord::Base
  has_many :lectures
  validate :start_time_before_end_time

  private
  def start_time_before_end_time
    errors.add_to_base("Godzina końca jest mniejsza od godziny początkowej") if self.end < self.start
  end
end
