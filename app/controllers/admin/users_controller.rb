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

  def update_group
    @user = User.find(params[:id])
    unless params[:user][:groups].blank?
      @user.groups << Group.find(params[:user][:groups])
      flash[:notice] = 'Wprowadzono zmiany'
      redirect_to [:admin, @user]
    else
      flash.now[:error] = 'Wybierz poprawną grupę, by dodać'
      render :action => 'edit'
    end
  end

  def update_classroom
    @user = User.find(params[:id])
    unless params[:user][:classroom].blank?
      @user.classroom = Classroom.find(params[:user][:classroom])
      flash[:notice] = 'Wprowadzono zmiany'
      redirect_to [:admin, @user]
    else
      flash.now[:error] = 'Wybierz poprawne pole, by dodać'
      render :action => 'edit'
    end
  end

  def update_family_ties
    @user = User.find(params[:id])
    unless params[:user][:parents].blank? && params[:user][:children].blank?
      @user.parents << User.find(params[:user][:parents]) unless params[:user][:parents].blank?
      @user.children << User.find(params[:user][:children]) unless params[:user][:children].blank?
      flash[:notice] = 'Wprowadzono zmiany'
      redirect_to [:admin, @user]
    else
      flash.now[:error] = 'Wybierz poprawne pole, by dodać'
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

  def delete_child
    @user = User.find(params[:id])
    @user.children.delete(User.find(params[:child_id]))
    redirect_to [:admin, @user]
  end

  def delete_classroom
    @user = User.find(params[:id])
    @user.classroom.users.delete(@user)
    redirect_to [:admin, @user]
  end

  def delete_group
    @user = User.find(params[:id])
    @user.groups.delete(Group.find(params[:group_id]))
    redirect_to [:admin, @user]
  end
end
