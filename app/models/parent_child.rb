class ParentChild < ActiveRecord::Base
  belongs_to :child, :class_name => "User"
  belongs_to :parent, :class_name => "User"

  validate :parent_and_child_have_correct_roles
  validates_uniqueness_of :child_id, :scope => :parent_id
  validates_uniqueness_of :parent_id, :scope => :child_id

  def parent_and_child_have_correct_roles
    errors.add_to_base("Opiekun i uczeń muszą należeć do odpowiednich grup, by móc stworzyć relację") unless self.child.try(is_student?) && self.parent.try(is_parent?)
  end
end
