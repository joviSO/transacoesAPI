# frozen_string_literal: true

module Admin
  class UsersController < ::ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, except: [:index]

    def index
      @users = User.page(params[:page]).per(5)
      render json: @users
    end

    def show
      render json: user_with_paginated_transactions
    end

    def promote
      @user.update!(admin: true)
      render json: @user
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def authenticate_admin!
      render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user&.admin?
    end

    def user_with_paginated_transactions
      user_attributes = @user.attributes
      user_attributes[:paginated_transactions] = @user.paginated_transactions(params[:page], 5)
      user_attributes
    end
  end
end
