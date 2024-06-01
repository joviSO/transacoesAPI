# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]
  skip_before_action :authenticate_request, except: %i[create show update]

  def show
    render json: user_with_paginated_transactions
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

  def user_with_paginated_transactions
    user_attributes = @user.attributes
    user_attributes[:paginated_transactions] = @user.paginated_transactions(params[:page], 5)
    user_attributes
  end
end
