class CreateLectures < ActiveRecord::Migration
  def self.up
    create_table :lectures do |t|
      t.references :subject
      t.string :hall
      t.references :order_of_the_day
      t.integer :day_of_week

      t.timestamps
    end
  end

  def self.down
    drop_table :lectures
  end
end
