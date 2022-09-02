module Api
  module V1
    class PostsController < ApplicationController
      def index
        if request.headers['X-User-Token']
          @user = User.find_by_api_token(request.headers['X-User-Token'])
          @posts = Post.where(user_id: @user)
          render json: { posts: @posts }, status: :ok
        else
          render json: 'Please use the correct key "X-User-Token" and the token provided', status: :ok
        end
      end
    end
  end
end
