class Admin::PreferencesController < Admin::AdminController
  def edit
    @orders = OrderOfTheDay.find(:all, :order => 'start ASC')
    @order = OrderOfTheDay.new
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

  def destroy
    @order = OrderOfTheDay.find(params[:order_id])
    @order.destroy
    redirect_to edit_admin_preference_path
  end

end
