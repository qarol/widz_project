class Subject < ActiveRecord::Base
  belongs_to :semester
  belongs_to :user
  belongs_to :team, :polymorphic => true
  belongs_to :subject_name
end
