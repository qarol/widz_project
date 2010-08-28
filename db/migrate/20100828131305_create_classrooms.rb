class CreateClassrooms < ActiveRecord::Migration
  def self.up
    create_table :classrooms do |t|
      t.string :hall
      t.date :year
      t.string :name_of_class
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :classrooms
  end
end
