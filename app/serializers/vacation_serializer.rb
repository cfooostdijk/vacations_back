# app/serializers/vacation_serializer.rb
class VacationSerializer < ActiveModel::Serializer
  attributes :id, :file_number, :employee_id, :vacation_start, :vacation_end, :kind, :motive, :status

  def vacation_start
    object.vacation_start.strftime('%d/%m/%Y')
  end

  def vacation_end
    object.vacation_end.strftime('%d/%m/%Y')
  end
end
