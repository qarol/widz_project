class CreateEventMarks < ActiveRecord::Migration
  def self.up
    create_table :event_marks do |t|
      t.string :content
      t.references :subject
      t.integer :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :event_marks
  end
end
