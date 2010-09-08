class Admin::SubjectsController < ApplicationController
  def index
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subjects = @semester.subjects
    store_location
  end

  def new
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups_of_year(false).flatten.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
    @subject = @semester.subjects.build
  end

  def show
    @semester = Semester.choosen_or_current(params[:semester_id])
    @subject = @semester.subjects.find(params[:id])
  end

  def edit
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups_of_year(false).flatten.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
    @subject = Subject.find(params[:id])
  end

  def create
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups_of_year(false).flatten.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
    name,id = params[:team_type_id].split("_")
    @subject = Subject.new(params[:subject])
    @subject.team = name.classify.constantize.find(id)
    if @subject.save
      flash[:notice] = 'Przedmiot został dodany'
      redirect_back_or_default(admin_subjects_path)
    else
      render :action => 'new'
    end
  end

  def update
    @semester = Semester.choosen_or_current(params[:semester_id])
    classrooms = @semester.classrooms_of_year(false).flatten.map{|cl| [cl.current_year(params[:semester_id]).to_s + cl.name_of_class, "Classroom_" + cl.id.to_s]}
    groups = @semester.groups_of_year(false).flatten.map{|cl| [cl.name_of_group, "Groups_" + cl.id.to_s]}
    @team = [ [ 'Grupa', groups ], [ 'Klasa', classrooms ] ]
    name,id = params[:team_type_id].split("_")
    @subject = Subject.find(params[:id])
    @subject.team = name.classify.constantize.find(id)
    if @subject.update_attributes(params[:subject])
      flash[:notice] = 'Przedmiot został zaktualizowany'
      redirect_back_or_default(admin_subjects_path)
    else
      render :action => 'edit'
    end
  end

end
