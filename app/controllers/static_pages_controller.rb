class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(:approved => true).paginate(page: params[:page], :per_page => 6)
  end

  def places
  end

  def blog
    @posts = Post.where(:approved => true).paginate(page: params[:page], :per_page => 12)
  end

  def about
  end

  def admin
    redirect_to(root_url) unless current_user.admin?
  end
end
