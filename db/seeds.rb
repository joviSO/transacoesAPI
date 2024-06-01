# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Limpa os dados existentes
if Rails.env.development?
  User.destroy_all
  Transaction.destroy_all

  # Cria 5 usuários
  5.times do |i|
    user = User.create!(
      username: Faker::Internet.unique.username,
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    )

    # Cria transações para os usuários
    transaction_count = i == 4 ? 20 : 5

    transaction_count.times do
      user.transactions.create!(
        card_number: Faker::Finance.credit_card,
        amount: Faker::Commerce.price(range: 10.0..1000.0),
        card_expiry_month: Faker::Number.between(from: 1, to: 12),
        card_expiry_year: Faker::Number.between(from: Date.today.year + 1, to: Date.today.year + 5),
        card_cvv: Faker::Number.number(digits: 3),
        status: Transaction.statuses.keys.sample
      )
    end
  end

  puts 'Seed data created successfully!'
end
