# frozen_string_literal: true

require 'roo'

class ExcelImportService
  def initialize(file_path)
    @file_path = file_path
    @errors = []
  end

  def import_data
    validate_excel_file!

    excel = Roo::Excelx.new(@file_path)
    has_valid_data = false

    excel.each_row_streaming(offset: 1) do |row|
      file_number = row[0]&.value
      name = row[1]&.value
      email = row[2]&.value
      lider = row[3]&.value
      vacation_start = row[4]&.value
      vacation_end = row[5]&.value
      kind = row[6]&.value
      motive = row[7]&.value
      status = row[8]&.value

      next unless [file_number, name, email, lider, vacation_start, vacation_end, motive, status, kind].any?(&:present?)

      has_valid_data = true

      parts = name.to_s.split(' ', 2)
      first_name = parts[0]
      last_name = parts[1].to_s

      begin
        employee = Employee.find_or_initialize_by(email:)
        employee.assign_attributes(
          file_number:,
          first_name:,
          last_name:,
          lider:
        )

        unless employee.save
          @errors << "Error al crear empleado '#{name}': #{employee.errors.full_messages.join(', ')}"
          Rails.logger.error "Error al crear empleado '#{name}': #{employee.errors.full_messages.join(', ')}"
        end

        vacation = Vacation.new(
          employee_id: employee.id,
          file_number:,
          vacation_start:,
          vacation_end:,
          kind:,
          motive:,
          status:
        )

        unless vacation.save
          @errors << "Error al crear vacación para empleado '#{name}': #{vacation.errors.full_messages.join(', ')}"
          Rails.logger.error "Error al crear vacación para empleado '#{name}': #{vacation.errors.full_messages.join(', ')}"
        end
      rescue StandardError => e
        @errors << "Error al procesar fila '#{row.inspect}': #{e.message}"
        Rails.logger.error "Error al procesar fila '#{row.inspect}': #{e.message}"
      end
    end

    if has_valid_data
      { success: @errors.empty?,
        message: @errors.empty? ? 'Datos importados exitosamente' : 'No se encontraron datos válidos para importar', errors: @errors }
    else
      { success: false, message: 'No se encontraron datos válidos para importar' }
    end
  rescue StandardError => e
    { success: false, errors: ["Error interno del servidor: #{e.message}"] }
  end

  private

  def validate_excel_file!
    extension = File.extname(@file_path).downcase
    return if ['.xlsx', '.xls'].include?(extension)

    raise StandardError, 'Invalid file format. Expected .xlsx or .xls'
  end
end
