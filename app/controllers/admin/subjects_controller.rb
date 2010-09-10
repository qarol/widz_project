class Admin::SubjectsController < ApplicationController
  before_filter :class_group, :only => [ :new, :edit, :create, :update ]
  before_filter :semestr_and_subject, :except => [ :index, :new, :create ]

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @semester = @classroom.current_semester(params[:semester_id])
    @subjects = @semester.subjects.all(:conditions => { :team_id => @classroom.id, :team_type => "Classroom" })
    store_location
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject = @classroom.subjects.build(:semester => @semester)
  end

  def show
  end

  def timetable
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.new
    @orders = OrderOfTheDay.all(:order => 'start ASC')
  end

  def edit
    @classroom = Classroom.find(params[:classroom_id])
  end

  def create
    @semester = Semester.choosen_or_current(params[:semester_id])
    name,id = params[:team_type_id].split("_")
    @subject = Subject.new(params[:subject])
    @subject.team = name.classify.constantize.find(id)
    @classroom = @subject.team
    @semester = @subject.semester
    if @subject.save
      flash[:notice] = 'Przedmiot został dodany'
      redirect_to admin_semester_classroom_subjects_path(@semester, @classroom)
    else
      render :action => 'new'
    end
  end

  def update
    name,id = params[:team_type_id].split("_")
    @subject.team = name.classify.constantize.find(id)
    @classroom = @subject.team
    @semester = @subject.semester
    if @subject.update_attributes(params[:subject])
      flash[:notice] = 'Przedmiot został zaktualizowany'
      redirect_to admin_semester_classroom_subject_path(@semester, @classroom, @subject)
    else
      render :action => 'edit'
    end
  end

  def create_lecture
    @lectures = @subject.lectures.all(:order => 'day_of_week ASC')
    @lecture = @subject.lectures.build(params[:lecture])
    @orders = OrderOfTheDay.all(:order => 'start ASC')
    if @lecture.save
      flash[:notice] = 'Termin został dodany'
      redirect_to timetable_admin_semester_classroom_subject_path
    else
      render :action => 'timetable'
    end
  end

  def delete_lecture
    if Lecture.destroy(params[:lecture_id])
      flash[:notice] = 'Termin został pomyślnie usunięty'
    else
      flash[:error] = 'Termin nie został usunięty'
    end
    @classroom = @subject.team
    @semester = @subject.semester
    redirect_to timetable_admin_semester_classroom_subject_path(@semester, @classroom, @subject)
  end

  private
  def class_group
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
  end
  def semestr_and_subject
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = Subject.find(params[:id])
  end
end
