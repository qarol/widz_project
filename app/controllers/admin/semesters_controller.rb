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

end
