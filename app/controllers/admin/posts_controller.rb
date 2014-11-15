class Admin::PostsController < AdminsController

  def approve
    Post.find(params[:id]).approve
    redirect_to admin_dashboard_path
  end

  def unapprove
    Post.find(params[:id]).unapprove
    redirect_to admin_dashboard_path
  end
end
