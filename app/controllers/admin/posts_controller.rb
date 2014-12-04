class Admin::PostsController < AdminsController

  def approve
    Post.find(params[:id]).approve
    flash[:success] = "Post approved"
    redirect_to admin_dashboard_path
  end

  def unapprove
    Post.find(params[:id]).unapprove
    flash[:success] = "Post unapproved"
    redirect_to admin_dashboard_path
  end
end
