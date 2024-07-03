# frozen_string_literal: true

module Api
  module V1
    class ExcelController < ApplicationController
      def import
        excel_file = params[:excel_file]

        if excel_file
          file_path = excel_file.tempfile.path

          import_service = ExcelImportService.new(file_path)
          import_service.import_data

          render json: { message: 'Datos importados exitosamente' }, status: :ok
        else
          render json: { message: 'Debe seleccionar un archivo Excel' }, status: :bad_request
        end
      rescue StandardError => e
        render json: { message: "Error al importar datos: #{e.message}" }, status: :internal_server_error
      end
    end
  end
end
