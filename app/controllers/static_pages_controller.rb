class StaticPagesController < ApplicationController
  include ApplicationHelper

  def home
    @home_page = Homepage.new(params)
  end

  def blog
    @posts = Post.approved.page(params[:page]).per(12)
  end

  def about
  end
end
