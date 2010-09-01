class CreateSemesters < ActiveRecord::Migration
  def self.up
    create_table :semesters do |t|
      t.integer :year
      t.integer :semester
      t.date :start
      t.date :end

      t.timestamps
    end
  end

  def self.down
    drop_table :semesters
  end
end
