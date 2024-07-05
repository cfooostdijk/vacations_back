# frozen_string_literal: true

# spec/controllers/api/v1/excel_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::ExcelController, type: :controller do
  describe 'POST #import' do
    let(:valid_excel_file) do
      fixture_file_upload('valid_excel_file.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    end
    let(:invalid_excel_file) { fixture_file_upload('invalid_excel_file_csv.csv', 'text/csv') }

    context 'when an excel file is provided' do
      context 'and the file is valid' do
        before do
          allow_any_instance_of(ExcelImportService).to receive(:import_data).and_return(success: true,
                                                                                        message: 'Datos importados exitosamente')
        end

        it 'returns a success message' do
          post :import, params: { excel_file: valid_excel_file }

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['message']).to eq('Datos importados exitosamente')
        end
      end

      context 'and the file is invalid' do
        it 'returns an error message' do
          post :import, params: { excel_file: invalid_excel_file }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to eq('El archivo no es un archivo Excel válido')
        end
      end
    end

    context 'when no file is provided' do
      it 'returns an error message' do
        post :import

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Debe seleccionar un archivo Excel')
      end
    end
  end
end
