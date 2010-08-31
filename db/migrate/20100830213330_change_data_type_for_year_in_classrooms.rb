class ChangeDataTypeForYearInClassrooms < ActiveRecord::Migration
  def self.up
    change_table :classrooms do |t|
      t.change :year, :integer
    end
  end

  def self.down
    change_table :classrooms do |t|
      t.change :year, :date
    end
  end
end
