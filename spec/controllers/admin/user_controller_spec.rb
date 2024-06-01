# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::TransactionsController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:transaction) { create(:transaction) }

  before do
    allow(controller).to receive(:authenticate_admin!).and_return(true)
    allow(controller).to receive(:current_user).and_return(admin)
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

  describe 'PUT #approve' do
    it 'returns a success response' do
      put :approve, params: { id: transaction.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #deny' do
    it 'returns a success response' do
      put :deny, params: { id: transaction.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
