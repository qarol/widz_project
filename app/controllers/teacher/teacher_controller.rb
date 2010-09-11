class Teacher::TeacherController < ApplicationController
  require_role "teacher"
end
