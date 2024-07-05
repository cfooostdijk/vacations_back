# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExcelImportService do
  let(:valid_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'valid_excel_file.xlsx').to_s }
  let(:invalid_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'invalid_excel_file.xlsx').to_s }
  let(:invalid_file_path_csv) { Rails.root.join('spec', 'fixtures', 'files', 'invalid_excel_file_csv.csv').to_s }

  describe '#import_data' do
    context 'with a valid file' do
      it 'imports data successfully' do
        service = described_class.new(valid_file_path)
        result = service.import_data

        expect(result[:success]).to be_truthy
        expect(result[:message]).to eq('Datos importados exitosamente')
      end
    end

    context 'with an invalid file' do
      before do
        allow(Roo::Excelx).to receive(:new).and_raise(StandardError, 'Invalid file format')
      end

      it 'returns an error message for invalid Excel file' do
        service = described_class.new(invalid_file_path)
        result = service.import_data

        expect(result[:success]).to be_falsey
        expect(result[:errors]).to include('Error interno del servidor: Invalid file format')
      end

      it 'returns an error message for CSV file' do
        service = described_class.new(invalid_file_path_csv)
        result = service.import_data

        expect(result[:success]).to be_falsey
        expect(result[:errors]).to include('Error interno del servidor: Invalid file format. Expected .xlsx or .xls')
      end
    end

    context 'when no valid data is found' do
      it 'returns a no valid data message' do
        service = described_class.new(invalid_file_path)
        result = service.import_data

        expect(result[:success]).to be_falsey
        expect(result[:message]).to eq('No se encontraron datos válidos para importar')
      end
    end
  end
end
