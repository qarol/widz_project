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
  def semestr_and_subject
    @subject = Subject.find(params[:id])
  end
end
