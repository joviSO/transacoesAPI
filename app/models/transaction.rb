# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, completed: 1, failed: 2 }

  validates :card_number, presence: true, length: { minimum: 6 }, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :card_expiry_date, presence: true
  validates :card_cvv, presence: true, length: { is: 3 }, numericality: { only_integer: true }

  validate :card_expiry_date_cannot_be_in_the_past

  private

  def card_expiry_date_cannot_be_in_the_past
    return unless card_expiry_date.present? && card_expiry_date < Date.today

    errors.add(:card_expiry_date, "Validade Expirada")
  end
end
