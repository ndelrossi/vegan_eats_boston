class StaticPagesController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: :admin

  def home
    @home_page = Homepage.new(params)
  end

  def blog
    @posts = Post.approved.page(params[:page]).per(12)
  end

  def about
  end
end
