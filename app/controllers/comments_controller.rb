class CommentsController < ApplicationController

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

  private

    def comments_params
      params.require(:comment).permit(:content)
    end
end