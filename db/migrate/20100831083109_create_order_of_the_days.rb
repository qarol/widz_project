class CreateOrderOfTheDays < ActiveRecord::Migration
  def self.up
    create_table :order_of_the_days do |t|
      t.time :start
      t.time :end

      t.timestamps
    end
  end

  def self.down
    drop_table :order_of_the_days
  end
end
