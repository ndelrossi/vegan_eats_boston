class PostsController < ApplicationController
  before_action :signed_in_user,  except: :show
  before_action :correct_user,   only: :destroy

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    signed_in_user
    @post = Post.new
    @user = current_user
  end

  def create
    @post = current_user.posts.build(post_params) if signed_in?
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'posts/new'
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
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end