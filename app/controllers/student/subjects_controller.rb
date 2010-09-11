class Student::SubjectsController < Student::StudentController
  before_filter :class_group, :only => [ :new, :edit, :create, :update ]
  before_filter :semestr_and_subject, :except => [ :index, :new, :create ]

  def index
    @user = current_user
    @subjects = @user.subjects
  end

  def show
  end

  def timetable
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.new
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  private
  def class_group
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
  end
  def semestr_and_subject
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:id])
  end
end
