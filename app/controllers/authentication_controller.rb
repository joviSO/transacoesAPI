# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = @user.generate_jwt
      render json: { token: }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
