class AddYearToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :year, :integer
  end

  def self.down
    remove_column :groups, :year
  end
end
