# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    allow(controller).to receive(:authenticate_request).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          transaction: {
            card_number: '1234567812345678',
            amount: 100,
            card_expiry_month: 12,
            card_expiry_year: 2025,
            card_cvv: '123',
            status: 'pending'
          }
        }
      end

      it 'creates a new transaction' do
        expect do
          post :create, params: valid_params
        end.to change(Transaction, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          transaction: {
            card_number: '',
            amount: nil,
            card_expiry_month: nil,
            card_expiry_year: nil,
            card_cvv: '',
            status: ''
          }
        }
      end

      it 'does not create a new transaction' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Transaction, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: transaction.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          id: transaction.id,
          transaction:
          {
            status: 'completed'
          }
        }
      end
    end
  end
end
