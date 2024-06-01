# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = extract_token_from_headers
    decoded_token = User.decode_jwt(token)
    @current_user = User.find_by(id: decoded_token[:id]) if decoded_token.present?
    raise StandardError unless @current_user
  rescue StandardError
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  def extract_token_from_headers
    header = request.headers['Authorization']
    header.split(' ').last if header.present?
  end
end
