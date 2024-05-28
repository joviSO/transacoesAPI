# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
    decoded_token = User.decode_jwt(token)
    @current_user = User.find_by(id: decoded_token[:id]) if decoded_token
  rescue StandardError
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
