class Admin::ClassroomsController < Admin::AdminController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classrooms = @semester.classrooms_of_year
    store_location
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.new(:year => @semester.try(:year))
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
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
  end

  def edit
    @classroom = Classroom.find(params[:id])
    @users = @classroom.students.sort_by{|u| u.lastname.capitalize}
  end

  def update
    @classroom = Classroom.find(params[:id])
    if @classroom.update_attributes(params[:classroom])
      flash[:notice] = 'Dane klasy zostały zaktualizowane'
      redirect_to [:admin, @classroom]
    else
      render :action => 'edit'
    end
  end

  def delete_user
    @classroom = Classroom.find(params[:id])
    @classroom.users.delete(User.find(params[:user_id]))
    flash[:notice] = 'Usunięto pomyślnie użytkownika'
    redirect_to [:admin, @classroom]
  end

end
