module Admin
  class TransactionsController < ::ApplicationController
    before_action :authenticate_admin!
    before_action :set_transaction, only: %i[show approve deny]

    # swagger_api :index do
    #   summary 'Permite aos Admins acessar a lista de todas as transações'
    #   notes 'Lista todas as transações'
    # end

    def index
      @transactions = Transaction.page(params[:page]).per(5)
      render json: @transactions
    end

    # swagger_api :show do
    #   summary 'Permite aos Admins acessar uma transação específica atraves do ID'
    #   notes 'Mostra uma transação específica'
    #   param :path, :id, :integer, :required, 'ID da transação'
    # end

    def show
      render json: @transaction
    end

    # swagger_api :approve do
    #   summary 'Permite aos Admins aprovar uma transação'
    #   notes 'Feito para simular a aprovação de uma transação'
    # end

    def approve
      @transaction.update!(status: :completed)
      render json: @transaction
    end

    # swagger_api :approve do
    #   summary 'Permite aos Admins negar uma transação'
    #   notes 'Feito para simular a negação de uma transação'
    # end

    def deny
      @transaction.update!(status: :failed)
      render json: @transaction
    end

    private

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def authenticate_admin!
      render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user&.admin?
    end
  end
end
