require 'roo'

class ExcelImportService
  def initialize(file_path)
    @file_path = file_path
    @errors = []
  end

  def import_data
    excel = Roo::Excelx.new(@file_path)
    has_valid_data = false

    excel.each_row_streaming(offset: 1) do |row|
      file_number = row[0].value
      name = row[1].value
      email = row[2].value
      lider = row[3].value
      vacation_start = row[4].value
      vacation_end = row[5].value
      motive = row[6].value
      status = row[7].value
      kind = row[8].value

      # Verificar si la fila tiene datos válidos
      if [file_number, name, email, lider, vacation_start, vacation_end, motive, status, kind].any?(&:present?)
        has_valid_data = true

        parts = name.split(' ', 2)
        first_name = parts[0]
        last_name = parts[1] || ''

        # Verificar si el empleado ya existe por correo electrónico
        employee = Employee.find_by(email: email)

        unless employee
          # Si el empleado no existe, intenta crear uno nuevo
          employee = Employee.new(
            file_number: file_number, # Usamos `employee_id` aquí
            first_name: first_name,
            last_name: last_name,
            email: email,
            lider: lider
          )

          unless employee.save
            @errors << "Error al crear empleado '#{name}': #{employee.errors.full_messages.join(', ')}"
            Rails.logger.error "Error al crear empleado '#{name}': #{employee.errors.full_messages.join(', ')}"
            return { success: false, errors: @errors }
          end
        end

        vacation = Vacation.new(
          employee_id: employee.id,
          file_number: file_number,
          vacation_start: vacation_start,
          vacation_end: vacation_end,
          motive: motive,
          status: status,
          kind: kind
        )

        unless vacation.save
          @errors << "Error al crear vacación para empleado '#{name}': #{vacation.errors.full_messages.join(', ')}"
          Rails.logger.error "Error al crear vacación para empleado '#{name}': #{vacation.errors.full_messages.join(', ')}"
          return { success: false, errors: @errors }
        end
      end
    end

    unless has_valid_data
      return { success: false, message: 'No se encontraron datos válidos para importar' }
    end

    { success: true, message: 'Datos importados exitosamente' }
  end
end
