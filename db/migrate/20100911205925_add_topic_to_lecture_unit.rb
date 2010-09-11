class AddTopicToLectureUnit < ActiveRecord::Migration
  def self.up
    add_column :lecture_units, :topic, :string, :default => ""
  end

  def self.down
    remove_column :lecture_units, :topic
  end
end
