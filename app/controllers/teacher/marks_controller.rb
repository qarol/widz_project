class Teacher::MarksController < Teacher::TeacherController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @classroom = @subject.team
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
    @event_marks = @subject.event_marks
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @classroom = @subject.team
    @event_mark = EventMark.new(:subject => @subject)
  end

  def show
  end

  def edit
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @event_mark = EventMark.find(params[:id])
    @classroom = @subject.team
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
  end

  def create
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @classroom = @subject.team
    @event_mark = EventMark.new(params[:event_mark])
    if @event_mark.save
      flash[:notice] = "Dodano nową grupę ocen"
      redirect_to teacher_subject_marks_path
    else
      render :action => 'new'
    end
  end

  def update
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:subject_id])
    @event_mark = EventMark.find(params[:id])
    @classroom = @subject.team
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
    @event_mark.marks = @users.map do |u|
      mark = Mark.find_or_create_by_user_id_and_event_mark_id(:user_id => u.id, :event_mark_id => @event_mark.id)
      mark.update_attributes(:value => params[:event_mark][:marks_ids][u.id.to_s].to_i)
      mark
    end
    if @event_mark.save
      flash[:notice] = 'Zapisano oceny'
      redirect_to edit_teacher_subject_mark_path(@subject)
    else
      render :action => 'edit'
    end
  end

end
