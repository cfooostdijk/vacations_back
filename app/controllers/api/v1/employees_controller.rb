# frozen_string_literal: true

module Api
  module V1
    # Controller for managing employees.
    class EmployeesController < ApplicationController
      before_action :set_employee, only: %i[show update destroy]

      def index
        @employees = filtered_employees
                     .order(file_number: :asc)
                     .page(params[:page]).per(8)

        render json: {
          employees: @employees,
          total_pages: @employees.total_pages,
          current_page: @employees.current_page,
          total_count: @employees.total_count
        }
      end

      def show
        render json: @employee
      end

      def create
        @employee = Employee.new(employee_params)
        if @employee.save
          render json: @employee, status: :created
        else
          render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @employee.update(employee_params)
          render json: @employee
        else
          render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @employee.destroy
      end

      private

      def filtered_employees
        employees = Employee.all
        employees.by_file_number(params[:file_number])
                 .by_first_name(params[:first_name])
                 .by_last_name(params[:last_name])
                 .by_email(params[:email])
                 .by_lider(params[:lider])
      end

      def set_employee
        @employee = Employee.find(params[:id])
      end

      def employee_params
        params.require(:employee).permit(:file_number, :first_name, :last_name, :email, :lider)
      end
    end
  end
end
