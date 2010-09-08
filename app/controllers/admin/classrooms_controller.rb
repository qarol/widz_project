class Admin::ClassroomsController < Admin::AdminController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classrooms = @semester.classrooms_of_year
    store_location
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = @semester.classrooms.build
  end

  def create
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.new(params[:classroom])
    if @classroom.save
      flash[:notice] = 'Klasa została utworzona'
      redirect_back_or_default [:admin, @semester, @classroom]
    else
      render :action => 'new'
    end
  end

  def show
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
    @orders = OrderOfTheDay.all(:order => "start ASC")
    @schedule = @classroom.subjects.all(:conditions => { :semester_id => @semester.id }).map(&:lectures).flatten
  end

  def edit
    @semester = Semester.choosen_or_current(params[:semester_id])
    @orders = OrderOfTheDay.all(:order => "start ASC")
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
    @schedule = @classroom.subjects.all(:conditions => { :semester_id => @semester.id }).map(&:lectures).flatten
  end

  def update
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    if @classroom.update_attributes(params[:classroom])
      flash[:notice] = 'Dane klasy zostały zaktualizowane'
      redirect_to [:admin, @semester, @classroom]
    else
      render :action => 'edit'
    end
  end

  def delete_user
    @classroom = Classroom.find(params[:id])
    @classroom.users.delete(User.find(params[:user_id]))
    flash[:notice] = 'Usunięto pomyślnie użytkownika'
    redirect_back_or_default [:admin, @semester, @classroom]
  end

  def students
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
  end

  def schedule
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:id])
    @orders = OrderOfTheDay.all(:order => "start ASC")
    @schedule = @classroom.subjects.all(:conditions => { :semester_id => @semester.id }).map(&:lectures).flatten
  end

end
