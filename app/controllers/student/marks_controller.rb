class Student::MarksController < Student::StudentController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @team = @subject.team
    @user = current_user
    @event_marks = @subject.event_marks
  end

  def show
  end
end
