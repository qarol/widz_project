class CreateParentChildren < ActiveRecord::Migration
  def self.up
    create_table :parent_children, :id => false do |t|
      t.integer "parent_id", "child_id"
    end
  end

  def self.down
    drop_table :parent_children
  end
end
