class Admin::PreferencesController < Admin::AdminController
  before_filter :order_new_and_all
  before_filter :subject_name_new_and_all
  
  def edit
  end

  def create
    @order = OrderOfTheDay.new(params[:order_of_the_day])
    if @order.save
      flash[:notice] = 'Lekcja została dodana'
      redirect_to edit_admin_preference_path
    else
      render :action => 'edit'
    end
  end

  def create_subject_name
    @subject_name = SubjectName.new(params[:subject_name])
    if @subject_name.save
      flash[:notice] = 'Przedmiot został dodany'
      redirect_to edit_admin_preference_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = OrderOfTheDay.find(params[:order_id])
    @order.destroy
    redirect_to edit_admin_preference_path
  end

  def destroy_subject_name
    @subject_name = SubjectName.find(params[:subject_name_id])
    @subject_name.destroy
    redirect_to edit_admin_preference_path
  end

  private
  def order_new_and_all
    @order = OrderOfTheDay.new
    @orders = OrderOfTheDay.find(:all, :order => 'start ASC')
  end
  def subject_name_new_and_all
    @subject_name = SubjectName.new
    @subject_names = SubjectName.find(:all, :order => 'name ASC')
  end
end
