# frozen_string_literal: true

module Api
  module V1
    # Controller for managing vacations.
    class VacationsController < ApplicationController
      before_action :set_vacation, only: %i[show update destroy]

      def index
        @vacations = filtered_vacations
                     .order(vacation_start: :asc)
                     .page(params[:page]).per(8)

        render json: {
          vacations: ActiveModelSerializers::SerializableResource.new(@vacations, each_serializer: VacationSerializer),
          total_pages: @vacations.total_pages,
          current_page: @vacations.current_page,
          total_count: @vacations.total_count
        }
      end

      def show
        render json: @vacation
      end

      def create
        employee = Employee.find_by(file_number: params[:vacation][:file_number])
        if employee
          @vacation = Vacation.new(vacation_params.merge(employee_id: employee.id))
          if @vacation.save
            render json: @vacation, status: :created
          else
            render json: { error: @vacation.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Empleado no encontrado' }, status: :unprocessable_entity
        end
      end

      def update
        if @vacation.update(vacation_params)
          render json: @vacation
        else
          render json: { error: @vacation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @vacation.destroy
      end

      private

      def filtered_vacations
        vacations = Vacation.all
        vacations.by_file_number(params[:file_number])
                 .by_vacation_start(params[:vacation_start])
                 .by_vacation_end(params[:vacation_end])
                 .by_motive(params[:motive])
                 .by_status(params[:status])
                 .by_kind(params[:kind])
      end

      def set_vacation
        @vacation = Vacation.find(params[:id])
      end

      def vacation_params
        params.require(:vacation).permit(:employee_id, :file_number, :vacation_start, :vacation_end, :motive, :status,
                                         :kind)
      end
    end
  end
end
