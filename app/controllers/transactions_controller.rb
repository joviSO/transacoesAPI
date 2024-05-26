# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update]

  def create
    @transaction = @current_user.transactions.build(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def index
    @transactions = @current_user.transactions
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def update
    if @transaction.update(transaction_update_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = @current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:card_number, :amount, :card_expiry_date, :card_cvv, :status)
  end

  def transaction_update_params
    params.require(:transaction).permit(:status)
  end
end
