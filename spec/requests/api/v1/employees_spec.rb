# frozen_string_literal: true

# spec/controllers/api/v1/employees_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of employees with pagination information' do
      create_list(:employee, 10)

      get :index, params: { page: 1 }

      expect(response).to be_successful
      expect(json_response['employees'].count).to eq(8)
      expect(json_response['total_pages']).to eq(2)
      expect(json_response['current_page']).to eq(1)
      expect(json_response['total_count']).to eq(10)
    end

    it 'filters employees by first name' do
      create(:employee, first_name: 'John')
      create(:employee, first_name: 'Jane')

      get :index, params: { first_name: 'John' }

      expect(response).to have_http_status(:ok)
      expect(json_response['employees'].count).to eq(1)
      expect(json_response['employees'][0]['first_name']).to eq('John')
    end

    it 'filters employees by file number' do
      create(:employee, file_number: '12345')
      create(:employee, file_number: '67890')

      get :index, params: { file_number: '12345' }

      expect(response).to have_http_status(:ok)
      expect(json_response['employees'].count).to eq(1)
      expect(json_response['employees'][0]['file_number'].to_s).to eq('12345')
    end

    it 'filters employees by email' do
      create(:employee, email: 'john.doe@example.com')
      create(:employee, email: 'jane.doe@example.com')

      get :index, params: { email: 'john.doe@example.com' }

      expect(response).to have_http_status(:ok)
      expect(json_response['employees'].count).to eq(1)
      expect(json_response['employees'][0]['email']).to eq('john.doe@example.com')
    end

    it 'filters employees by lider' do
      create(:employee, lider: 'Alice')
      create(:employee, lider: 'Bob')

      get :index, params: { lider: 'Alice' }

      expect(response).to have_http_status(:ok)
      expect(json_response['employees'].count).to eq(1)
      expect(json_response['employees'][0]['lider']).to eq('Alice')
    end
  end

  describe 'GET #show' do
    it 'returns a single employee' do
      employee = create(:employee)

      get :show, params: { id: employee.id }

      expect(response).to be_successful
      expect(json_response['id']).to eq(employee.id)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new employee' do
        employee_params = attributes_for(:employee)

        expect do
          post :create, params: { employee: employee_params }
        end.to change(Employee, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new employee' do
        invalid_employee_params = attributes_for(:employee, first_name: nil)

        expect do
          post :create, params: { employee: invalid_employee_params }
        end.to_not change(Employee, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to include("First name can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    it 'updates the employee with valid params' do
      employee = create(:employee)
      new_first_name = 'Updated First Name'

      put :update, params: { id: employee.id, employee: { first_name: new_first_name } }

      expect(response).to be_successful
      expect(employee.reload.first_name).to eq(new_first_name)
    end

    it 'does not update the employee with invalid params' do
      employee = create(:employee)

      put :update, params: { id: employee.id, employee: { first_name: nil } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response['errors']).to include("First name can't be blank")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the employee' do
      employee = create(:employee)

      expect do
        delete :destroy, params: { id: employee.id }
      end.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
