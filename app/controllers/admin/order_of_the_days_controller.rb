class Admin::OrderOfTheDaysController < Admin::AdminController
  def create
    @order = OrderOfTheDay.new(params[:order_of_the_day])
    if @order.save
      flash[:notice] = 'Lekcja została dodana'
      redirect_to edit_admin_preference_path
    else
      render 'admin/preferences/edit'
    end
  end
end
