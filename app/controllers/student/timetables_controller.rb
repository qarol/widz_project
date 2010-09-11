class Student::TimetablesController < Student::StudentController
  def show
    @user = current_user 
    @lectures = @user.subjects.map(&:lectures).flatten
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

end
