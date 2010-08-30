class CreateParentChildren < ActiveRecord::Migration
  def self.up
    create_table :parent_children, :id => false do |t|
      t.integer "parent_id", "child_id"
    end
    add_index "parent_children", "parent_id"
    add_index "parent_children", "child_id"
  end

  def self.down
    drop_table :parent_children
  end
end
