class AddActiveColumnToSemester < ActiveRecord::Migration
  def self.up
    add_column :semesters, :active, :bool, :default => false
  end

  def self.down
    remove_column :semesters, :active
  end
end
