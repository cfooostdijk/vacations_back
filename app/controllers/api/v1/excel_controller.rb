# frozen_string_literal: true

module Api
  module V1
    # Controller for managing imports.
    class ExcelController < ApplicationController
      def import
        excel_file = params[:excel_file]

        if excel_file
          process_import(excel_file)
        else
          render json: { message: 'Debe seleccionar un archivo Excel' }, status: :bad_request
        end
      end

      private

      def process_import(excel_file)
        if valid_excel_file?(excel_file)
          file_path = excel_file.tempfile.path

          import_data(file_path)
        else
          render json: { message: 'El archivo no es un archivo Excel válido' }, status: :unprocessable_entity
        end
      end

      def valid_excel_file?(file)
        %w[application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
           application/vnd.ms-excel].include?(file.content_type)
      end

      def import_data(file_path)
        import_service = ExcelImportService.new(file_path)
        import_result = import_service.import_data

        render json: { message: 'Datos importados exitosamente', details: import_result }, status: :ok
      rescue ExcelImportService::ImportError => e
        render json: { message: "Error al importar datos: #{e.message}" }, status: :unprocessable_entity
      rescue StandardError => e
        render json: { message: "Error interno del servidor: #{e.message}" }, status: :internal_server_error
      end
    end
  end
end
