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

  def update_family_ties
    @user = User.find(params[:id])
    unless params[:user][:parents].blank?
      @user.parents << User.find(params[:user][:parents]) unless params[:user][:parents].blank?
      flash[:notice] = 'Wprowadzono zmiany'
      redirect_to [:admin, @user]
    else
      flash.now[:error] = 'Wybierz opiekuna, by dodać'
      render :action => 'edit'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.roles = Role.find_all_by_id(params[:user][:role_ids])
    if @user.update_attributes(params[:user])
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
