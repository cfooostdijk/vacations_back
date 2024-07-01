module Api
  module V1
    class VacationsController < ApplicationController
      before_action :set_vacation, only: [:show, :update, :destroy]

      def index
        @vacations = Vacation.all.page(params[:page]).per(8)

        @vacations = @vacations.by_status(params[:status])
                               .by_kind(params[:kind])
                               .by_vacation_start(params[:vacation_start])
                               .by_vacation_end(params[:vacation_end])

        render json: {
                      vacations: @vacations,
                      total_pages: @vacations.total_pages,
                      current_page: @vacations.current_page,
                      total_count: @vacations.total_count
                     }
      end

      def show
        render json: @vacation
      end

      def create
        @vacation = Vacation.new(vacation_params)
        if @vacation.save
          render json: @vacation, status: :created
        else
          render json: @vacation.errors, status: :unprocessable_entity
        end
      end

      def update
        if @vacation.update(vacation_params)
          render json: @vacation
        else
          render json: @vacation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @vacation.destroy
      end

      private

      def set_vacation
        @vacation = Vacation.find(params[:id])
      end

      def vacation_params
        params.require(:vacation).permit(:employee_id, :vacation_start, :vacation_end, :motive, :status, :kind)
      end
    end
  end
end
