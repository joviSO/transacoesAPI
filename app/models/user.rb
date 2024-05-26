# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password

  has_many :transactions, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password,
            length: { in: 6..20 },
            if: -> { new_record? || !password.nil? }

  def generate_jwt
    JWT.encode({ id:, exp: 1.day.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def self.decode_jwt(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new decoded_token
  rescue StandardError
    nil
  end
end
