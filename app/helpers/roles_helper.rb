module RolesHelper
  def human_role role
    case role
    when "admin":
      "administrator"
    when "student":
      "uczeń"
    when "parent":
      "opiekun"
    when "teacher":
      "nauczyciel"
    else
      "brak przydziału"
    end
  end
end
