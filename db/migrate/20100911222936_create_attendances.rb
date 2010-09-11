class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.references :user
      t.boolean :excuse, :default => false
      t.string :type
      t.references :lecture_unit

      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
