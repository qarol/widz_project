class Admin::GroupsController < Admin::AdminController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @groups = @semester.groups
  end

  def show
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    @users = @group.users
    @subject = @group.subject
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.new(:semester => @semester)
  end

  def edit
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    @group.subject ||= Subject.new(:semester => @semester)
    @users = @group.users
  end

  def create
    @group = Group.new(params[:group])
    @semester = @group.semester
    if @group.save
      flash[:notice] = 'Nowa grupa została utworzona'
      redirect_to [:admin, @semester, @group]
    else
      render :action => 'edit'
    end
  end

  def update
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      @semester = @group.semester
      flash[:notice] = 'Dane grupy zostały zaktualizowane'
      redirect_to [:admin, @semester, @group]
    else
      render :action => 'edit'
    end
  end

  def timetable
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    @subject = @group.subject
    unless @subject.nil?
      @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
      @lecture = @subject.lectures.new
      @orders = OrderOfTheDay.all(:order => 'start ASC')
    end
  end
  
  def create_lecture
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    @subject = @group.subject
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.build(params[:lecture])
    @orders = OrderOfTheDay.all(:order => 'start ASC')
    if @lecture.save
      flash[:notice] = 'Termin został dodany'
      redirect_to timetable_admin_semester_group_path
    else
      render :action => 'timetable'
    end
  end

  def delete_lecture
    @group = Group.find(params[:id])
    @subject = @group.subject
    if Lecture.destroy(params[:lecture_id])
      flash[:notice] = 'Termin został pomyślnie usunięty'
    else
      flash[:error] = 'Termin nie został usunięty'
    end
    @semester = @subject.semester
    redirect_to timetable_admin_semester_group_path(@semester, @group)
  end

  def users
    @semester = Semester.choosen_or_current(params[:semester_id])
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def delete_user
    @group = Group.find(params[:id])
    @group.users.delete(User.find(params[:user_id]))
    redirect_to [:admin, @group]
  end

end
