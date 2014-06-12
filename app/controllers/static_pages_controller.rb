class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(:approved => true).paginate(page: params[:page], :per_page => 10)
  end

  def places
  end

  def about
  end

  def admin
    redirect_to(root_url) unless current_user.admin?
  end
end
