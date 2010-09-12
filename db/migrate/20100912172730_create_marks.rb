class CreateMarks < ActiveRecord::Migration
  def self.up
    create_table :marks do |t|
      t.references :user
      t.text :content, :default => ""
      t.integer :value, :default => 0
      t.references :event_mark

      t.timestamps
    end
  end

  def self.down
    drop_table :marks
  end
end
