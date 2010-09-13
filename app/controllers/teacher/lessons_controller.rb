class Teacher::LessonsController < Teacher::TeacherController
  before_filter :semestr_and_subject, :except => [ :index, :new, :create ]

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @semester = @classroom.current_semester(params[:semester_id])
    @subjects = @semester.subjects.all(:conditions => { :team_id => @classroom.id, :team_type => "Classroom" })
    store_location
  end

  def show
  end

  def timetable
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.new
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  def rate
    @team = @subject.team
    @users = @team.students.sort_by{|u| u.lastname.capitalize}
    @event_marks = @subject.event_marks
  end

  private
  def semestr_and_subject
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:id])
  end
end
