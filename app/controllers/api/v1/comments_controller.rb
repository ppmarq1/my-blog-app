<<<<<<< HEAD
module Api
  module V1
    class CommentsController < ApplicationController
      def index
        if request.headers['X-User-Token']
          @user = User.find_by_api_token(request.headers['X-User-Token'])
          @post = Post.where(id: params[:id])
          @comments = Comment.where(user_id: @user, post_id: @post)
          render json: { comments: @comments }, status: :ok
        else
          render json: 'Please use the correct key "X-User-Token" and the token provided', status: :ok
        end
      end

      def create
        if request.headers['X-User-Token']
          @user = User.find_by_api_token(request.headers['X-User-Token'])
          comment = @user.comments.new(text: params[:comment])
          comment.post_id = params[:id].to_i
          comment.update_comments_posts_counter
          if comment.save
            render json: 'Comment created', status: :created
          else
            render json: 'Error! Please try again', status: :unprocessable_entity
          end
        else
          render json: 'Please use the correct key "X-User-Token" and the token provided', status: :ok
        end
      end
    end
  end
=======
class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.find(params[:post_id])
    @comments = @posts.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], post_id: @post.id)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Comment created successfully' }

        format.json { render json: @comment, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
>>>>>>> aaca1d9e0f6937d7546c3e9c05ca62b7bb40e086
end
