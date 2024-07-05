# frozen_string_literal: true

module Users
  # Controller for managing registrations.
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :authenticate_user!, only: [:create]

    include RackSessionFix
    respond_to :json

    def create
      super do |resource|
        if resource.errors.any?
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
          return
        end
      end
    end

    private

    def respond_with(resource, _opts = {})
      case request.method_symbol
      when :post
        handle_successful_signup(resource)
      when :delete
        handle_account_deletion
      else
        handle_signup_failure(resource)
      end
    end

    def handle_successful_signup(resource)
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    end

    def handle_account_deletion
      render json: {
        status: { code: 200, message: 'Account deleted successfully.' }
      }, status: :ok
    end

    def handle_signup_failure(resource)
      render json: {
        status: { code: 422, message: "User couldn't be created successfully.
                  #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
