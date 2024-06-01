# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_request
  before_action :set_transaction, only: %i[show update]

  def create
    expiry_date = Date.new(transaction_params[:card_expiry_year].to_i, transaction_params[:card_expiry_month].to_i, -1)

    @transaction = @current_user.transactions.build(transaction_params)

    @transaction.status = :failed if expiry_date <= Date.today

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def index
    @transactions = Transaction.page(params[:page]).per(5)
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
    params.require(:transaction).permit(
      :card_number, :amount, :card_expiry_month, :card_expiry_year, :card_cvv, :status
    )
  end

  def transaction_update_params
    params.require(:transaction).permit(:status)
  end
end
