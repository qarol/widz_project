class CreateClassroomUsers < ActiveRecord::Migration
  def self.up
    create_table :classroom_users, :id => false do |t|
      t.references :user
      t.references :classroom
    end
    add_index "classroom_users", "user_id"
    add_index "classroom_users", "classroom_id"
  end

  def self.down
    drop_table :classroom_users
  end
end
