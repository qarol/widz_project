class Teacher::ClassroomsController < Teacher::TeacherController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @user = current_user
    @classrooms = @user.classrooms
    store_location
  end

  def show
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
    @orders = OrderOfTheDay.all(:order => "start ASC")
    @schedule = @classroom.subjects.all(:conditions => { :semester_id => @semester.id }).map(&:lectures).flatten
  end

  def students
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
  end

  def schedule
    @classroom = Classroom.find(params[:id])
    @semester = @classroom.current_semester(params[:semester_id])
    @orders = OrderOfTheDay.all(:order => "start ASC")
    @schedule = @classroom.subjects.all(:conditions => { :semester_id => @semester.id }).map(&:lectures).flatten
  end

end
