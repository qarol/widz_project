class ParentChild < ActiveRecord::Base
  belongs_to :child, :class_name => "User"
  belongs_to :parent, :class_name => "User"
end
