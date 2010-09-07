class CreateSubjectNames < ActiveRecord::Migration
  def self.up
    create_table :subject_names do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :subject_names
  end
end
