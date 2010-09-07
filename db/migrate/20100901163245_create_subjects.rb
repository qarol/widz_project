class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.references :subject_name
      t.references :semester
      t.references :user
      t.references :team, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
