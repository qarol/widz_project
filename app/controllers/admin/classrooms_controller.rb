class Admin::ClassroomsController < Admin::AdminController
  def index
    @classrooms_0 = Classroom.choose_year(0).sort_by{|c| c.name_of_class}
    @classrooms_1 = Classroom.choose_year(1).sort_by{|c| c.name_of_class}
    @classrooms_2 = Classroom.choose_year(2).sort_by{|c| c.name_of_class}
    @classrooms_3 = Classroom.choose_year(3).sort_by{|c| c.name_of_class}
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(params[:classroom])
    if @classroom.save
      flash[:notice] = 'Klasa została utworzona'
      redirect_to [:admin, @classroom]
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
