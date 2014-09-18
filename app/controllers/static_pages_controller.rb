class StaticPagesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: :admin

  def home
    @posts = Post.includes(:user).where(:approved => true).page(params[:page]).per(5)
    @places = Place.includes(:categories).order( 'rating DESC' ).limit(5)
    @reviews = Review.order( 'created_at DESC' ).limit(3)
  end

  def blog
    @posts = Post.where(:approved => true).page(params[:page]).per(12)
  end

  def about
  end

  def admin
    @posts = Post.page(params[:page]).per(10)
    @users = User.page(params[:page]).per(10)
    @places = Place.page(params[:page]).per(25)
    @reviews = Review.page(params[:page]).per(10)
  end
end
