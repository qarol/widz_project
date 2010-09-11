class CreateLectureUnits < ActiveRecord::Migration
  def self.up
    create_table :lecture_units do |t|
      t.date :date
      t.references :lecture

      t.timestamps
    end
  end

  def self.down
    drop_table :lecture_units
  end
end
