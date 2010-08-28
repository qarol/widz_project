class ParentChild < ActiveRecord::Base
  belongs_to :child, :class_name => "User"
  belongs_to :parent, :class_name => "User"

  validate :parent_and_child_have_correct_roles

  def parent_and_child_have_correct_roles
    errors.add_to_base("Opiekun i uczeń muszą należeć do odpowiednich grup, by móc stworzyć relację") unless self.child.is_student? && self.parent.is_parent?
  end
end
