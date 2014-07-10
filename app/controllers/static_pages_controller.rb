class StaticPagesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: :admin

  def home
    @posts = Post.where(:approved => true).page(params[:page]).per(6)
  end

  def blog
    @posts = Post.where(:approved => true).page(params[:page]).per(12)
  end

  def about
  end

  def admin
    @posts = Post.page(params[:page]).per(10)
    @comments = Comment.page(params[:page]).per(10)
    @users = User.limit(10).page(params[:page]).per(10)
    @places = Place.limit(10).page(params[:page]).per(10)
    @reviews = Review.limit(10).page(params[:page]).per(10)
  end
end
