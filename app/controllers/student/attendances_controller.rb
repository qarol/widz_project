class Student::AttendancesController < ApplicationController
  def index
    @attendances = current_user.attendances
  end

end
