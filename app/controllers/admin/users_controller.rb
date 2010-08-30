class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:parents].blank? && !params[:user][:parents].nil?
      flash.now[:error] = 'Wybierz opiekuna, by dodać'
      render :action => 'edit'
    elsif @user.update_attributes(params[:user])
      @user.parents << User.find(params[:user][:parents]) unless params[:user][:parents].blank?
      flash[:notice] = 'Wprowadzono zmiany'
      redirect_to [:admin, @user]
    else
      render :action => 'edit'
    end
  end

  def delete_parent
    @user = User.find(params[:id])
    @user.parents.delete(User.find(params[:parent_id]))
    redirect_to [:admin, @user]
  end

end
