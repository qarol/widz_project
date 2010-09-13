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

end
