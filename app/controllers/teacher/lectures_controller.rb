class Teacher::LecturesController < Teacher::TeacherController
  def index
    @first_day = params[:first_day].nil? ? LectureUnit.last_monday : Date.strptime(params[:first_day], "%F")
    @lectures = current_user.teacher_subjects.map(&:lectures).flatten
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  def show
    @lecture = Lecture.find(params[:id])
    @date = Date.strptime(params[:date], "%F")
    @lecture_unit = LectureUnit.find_or_create_by_date_and_lecture_id(:date => @date, :lecture_id => @lecture.id)
  end

  def attendances
    @lecture = Lecture.find(params[:id])
    @date = Date.strptime(params[:date], "%F")
    @lecture_unit = LectureUnit.find_or_create_by_date_and_lecture_id(:date => @date, :lecture_id => @lecture.id)
    @users = @lecture.subject.team.users.sort_by{|s| s.lastname}
  end

  def edit
    @lecture = Lecture.find(params[:id])
    @date = Date.strptime(params[:date], "%F")
    @lecture_unit = LectureUnit.find_or_create_by_date_and_lecture_id(:date => @date, :lecture_id => @lecture.id)
  end

  def update
    @lecture = Lecture.find(params[:id])
    @date = Date.strptime(params[:date], "%F")
    @lecture_unit = LectureUnit.find_or_create_by_date_and_lecture_id(:date => @date, :lecture_id => @lecture.id)
    if @lecture_unit.update_attributes(params[:lecture_unit])
      flash[:notice] = 'Lekcja została zaktualizowana'
      redirect_to teacher_lecture_path(@lecture, :date => @date)
    else
      render :action => 'edit'
    end
  end

  def update_attendances
    @lecture = Lecture.find(params[:id])
    @date = Date.strptime(params[:day], "%F")
    @lecture_unit = LectureUnit.find_or_create_by_date_and_lecture_id(:date => @date, :lecture_id => @lecture.id)
    @lecture_unit.attendances = User.find_all_by_id(params[:lecture_unit][:attendance_ids]).map{|u| Attendance.find_or_create_by_lecture_unit_id_and_user_id(:user_id => u.id, :lecture_unit_id => @lecture_unit.id)}
    if @lecture_unit.save
      flash[:notice] = "Zapisano frekwencję"
      redirect_to attendances_teacher_lecture_path(:date => @date)
    else
      render :action => 'edit'
    end
  end

end
