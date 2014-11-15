class PostsController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user,  except: :show
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @posts = Post.approved.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Post created! It will show on home page after approval."
      redirect_to @post
    else
      render 'posts/new'
    end
  end

  def edit
  end

  def update
    if @post.updaae_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :image)
    end

    def correct_user
      if current_user.admin?
        @post = Post.find(params[:id])
      else
        @post = current_user.posts.find(params[:id])
      end
      redirect_to root_url if @post.nil?
    end
end
