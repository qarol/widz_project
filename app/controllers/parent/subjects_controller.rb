class Parent::SubjectsController < Parent::ParentController
  def index
    @user = User.find(params[:child_id])
    @subjects = @user.subjects
  end

  def show
    @user = User.find(params[:child_id])
    @subject = Subject.find(params[:id])
  end

  def timetable
    @user = User.find(params[:child_id])
    @subject = Subject.find(params[:id])
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.new
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  private
  def semestr_and_subject
    @subject = Subject.find(params[:id])
  end
end
