class Student::StudentController < ApplicationController
  require_role "student"
end
