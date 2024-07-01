# frozen_string_literal: true

# spec/controllers/api/v1/vacations_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::VacationsController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of vacations with pagination information' do
      user = create(:user)
      sign_in user

      create_list(:vacation, 10)

      get :index, params: { page: 1 }

      expect(response).to be_successful
      expect(json_response['vacations'].count).to eq(8) # Ajusta según la paginación
      expect(json_response['total_pages']).to eq(2)
      expect(json_response['current_page']).to eq(1)
      expect(json_response['total_count']).to eq(10)
    end

    it 'filters vacations by status' do
      user = create(:user)
      sign_in user

      create(:vacation, status: 'approved')
      create(:vacation, status: 'pending')

      get :index, params: { status: 'approved' }

      expect(response).to have_http_status(:ok)
      expect(json_response['vacations'].count).to eq(1)
      expect(json_response['vacations'][0]['status']).to eq('approved')
    end
  end

  describe 'GET #show' do
    it 'returns a single vacation' do
      user = create(:user)
      sign_in user

      vacation = create(:vacation)

      get :show, params: { id: vacation.id }

      expect(response).to be_successful
      expect(json_response['id']).to eq(vacation.id)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new vacation' do
        user = create(:user)
        sign_in user

        employee = create(:employee)
        vacation_params = attributes_for(:vacation, employee_id: employee.id)

        expect do
          post :create, params: { vacation: vacation_params }
        end.to change(Vacation, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new vacation' do
        user = create(:user)
        sign_in user

        invalid_vacation_params = attributes_for(:vacation, vacation_start: nil)

        expect do
          post :create, params: { vacation: invalid_vacation_params }
        end.not_to change(Vacation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:vacation) { create(:vacation) }

    context 'with valid params' do
      it 'updates the vacation' do
        user = create(:user)
        sign_in user

        new_status = 'approved'

        put :update, params: { id: vacation.id, vacation: { status: new_status } }

        expect(response).to be_successful
        expect(vacation.reload.status).to eq(new_status)
      end
    end

    context 'with invalid params' do
      it 'does not update the vacation' do
        user = create(:user)
        sign_in user

        put :update, params: { id: vacation.id, vacation: { vacation_start: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the vacation' do
      user = create(:user)
      sign_in user

      vacation = create(:vacation)

      expect do
        delete :destroy, params: { id: vacation.id }
      end.to change(Vacation, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
