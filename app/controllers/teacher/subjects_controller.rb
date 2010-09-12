class Teacher::SubjectsController < Teacher::TeacherController
  def index
    # klasy i grupy z obecnego semestru
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classrooms_and_groups = current_user.teach_subjects.semester(@semester.id).group_by(&:team_type)
  end

  def show
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:id])
    @classroom = @subject.team
  end
end
