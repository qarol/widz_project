class Admin::GroupsController < Admin::AdminController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:notice] = 'Nowa grupa została utworzona'
      redirect_to [:admin, @group]
    else
      render :action => 'edit'
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = 'Dane grupy zostały zaktualizowane'
      redirect_to [:admin, @group]
    else
      render :action => 'edit'
    end
  end

  def delete_user
    @group = Group.find(params[:id])
    @group.users.delete(User.find(params[:user_id]))
    redirect_to [:admin, @group]
  end

end
