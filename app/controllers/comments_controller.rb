class CommentsController < ApplicationController
  before_action :correct_user,   only: [:destroy]

  def index
    @comments = Comment.paginate(page: params[:page])
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to post_url(@post)
    else
      redirect_to new_user_url
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_url
  end

  private

    def comments_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      if current_user.admin?
        @comment ||= @comment = Comment.find(params[:id])
      end
      redirect_to root_url if @comment.nil?
    end
end