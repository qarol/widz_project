class Teacher::PersonsController < Teacher::TeacherController
  def show
    @user = User.find(params[:id])
    @classroom = @user.classroom
  end

  def attendances
    @user = User.find(params[:id])
    @classroom = @user.classroom
    @attendances = @user.attendances
  end

  def timetable
    @user = User.find(params[:id])
    @classroom = @user.classroom
    @lectures = @user.subjects.map(&:lectures).flatten
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  def absence
    @user = User.find(params[:id])
    attendance = Attendance.find(params[:attendance_id])
    if attendance.update_attributes(:excuse => true)
      flash[:notice] = "Usprawiedliwiono godzinę"
    else
      flash[:error] = 'Nie usprawiedliwiono godziny'
    end
    redirect_to attendances_teacher_person_path
  end

end
