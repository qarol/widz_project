class AddRemoveSomeColumnsInGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :semester_id, :integer
    remove_column :groups, :year
  end

  def self.down
    remove_column :groups, :semester_id
    add_column :groups, :year, :integer
  end
end
