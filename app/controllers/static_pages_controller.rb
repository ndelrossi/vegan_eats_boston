class StaticPagesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: :admin

  def home
    @posts = Post.where(:approved => true).paginate(page: params[:page], :per_page => 6)
  end

  def blog
    @posts = Post.where(:approved => true).paginate(page: params[:page], :per_page => 12)
  end

  def about
  end

  def admin
    @posts = Post.paginate(page: params[:page], :per_page => 10)
    @comments = Comment.paginate(page: params[:page], :per_page => 10)
    @users = User.paginate(page: params[:page], :per_page => 10)
    @places = Place.paginate(page: params[:page], :per_page => 10)
    @reviews = Review.paginate(page: params[:page], :per_page => 10)
  end
end
