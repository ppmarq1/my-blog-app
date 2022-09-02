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
end
