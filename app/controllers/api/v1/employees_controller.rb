module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_employee, only: [:show, :update, :destroy]

      def index
        @employees = Employee.all.page(params[:page]).per(8)

        @employees = @employees.by_first_name(params[:first_name])
                               .by_last_name(params[:last_name])
                               .by_email(params[:email])
                               .by_lider(params[:lider])

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
          render json: @employee.errors, status: :unprocessable_entity
        end
      end

      def update
        if @employee.update(employee_params)
          render json: @employee
        else
          render json: @employee.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @employee.destroy
      end

      private

      def set_employee
        @employee = Employee.find(params[:id])
      end

      def employee_params
        params.require(:employee).permit(:first_name, :last_name, :email, :lider)
      end
    end
  end
end
