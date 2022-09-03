class Api::V1::UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def login
    valid = User.find_by(email: params[:email]).valid_password?(params[:password])
    if valid
      @user = User.find_by(email: params[:email])
      @user.save
      respond_to do |format|
        format.json { render json: @user }
      end
    else
      render json: 'Please provide correct email and password'.to_json, status: :ok
    end
  end
end
