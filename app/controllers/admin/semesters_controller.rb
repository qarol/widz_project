class Admin::SemestersController < ApplicationController
  def index
    @semesters = Semester.find(:all, :order => 'year DESC, semester DESC')
  end

  def new
    @semester = Semester.new
  end

  def show
    @semester = Semester.find(params[:id])
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def create
    @semester = Semester.new(params[:semester])
    if @semester.save
      flash[:notice] = 'Dodano nowy semester'
      redirect_to [:admin, @semester]
    else
      render :action => 'new'
    end
  end

  def update
    @semester = Semester.find(params[:id])
    if @semester.update_attributes(params[:semester])
      flash[:notice] = 'Zaktualizowano parametry semestru'
      redirect_to [:admin, @semester]
    else
      render :action => 'edit'
    end
  end

  def edit_change_semester
    @semesters = Semester.find(:all, :order => 'year DESC, semester DESC')
  end

  def update_change_semester
    if Semester.update_active(params[:active_id])
      flash[:notice] = "Semestr został poprawnie wybrany"
    else
      flash[:error] = "Semestr nie został poprawnie wybrany"
    end
    redirect_to edit_change_semester_admin_semesters_path
  end
end
