class PostsController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user,  except: :show
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: [:approve, :unapprove, :index_admin]

  def index
    @posts = Post.where(:approved => true).page(params[:page]).per(20)
  end

  def index_admin
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = current_user.posts.build(post_params)
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
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def approve
    @post = Post.find(params[:id])
    if @post.update_attribute(:approved, true)
      redirect_to posts_index_admin_path
    else
      redirect_to posts_index_admin_path
    end 
  end

  def unapprove
    @post = Post.find(params[:id])
    if @post.update_attribute(:approved, false)
      redirect_to posts_index_admin_path
    else
      redirect_to posts_index_admin_path
    end 
  end

  def destroy
    @post.destroy
    #redirect_to posts_index_admin_path if current_user.admin? and return
    redirect_to posts_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :image)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      if current_user.admin?
        @post ||= @post = Post.find(params[:id])
      end
      redirect_to root_url if @post.nil?
    end
end