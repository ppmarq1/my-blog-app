class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(post_id: @post.id, user_id: current_user.id, text: comment_params)
    @comment.post_id = @post.id
    @comment.update_comments_posts_counter
    if @comment.save
      redirect_to user_post_path(current_user, @post.id)
    else
      flash.now[:error] = 'Error: Comment can not be saved. Please try again.'
    end
  end

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
