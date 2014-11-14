class Admin::UsersController < AdminsController

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to admin_dashboard_path
  end
end
