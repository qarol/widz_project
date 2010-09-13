class Parent::ChildrenController < Parent::ParentController
  def index
    @children = current_user.children
  end

  def show
    @user = User.find(params[:id])
  end

  def attendances
    @user = User.find(params[:id])
    @attendances = @user.attendances
  end

  def timetable
    @user = User.find(params[:id])
    @lectures = @user.subjects.map(&:lectures).flatten
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  def absence
    @user = User.find(params[:id])
    attendance = Attendance.find(params[:attendance_id])
    if attendance.update_attributes(:excuse => true)
      flash[:notice] = "Usprawiedliwiono godzinę"
    else
      flash[:error] = 'Nie usprawiedliwiono godziny'
    end
    redirect_to attendances_parent_child_path
  end

end
