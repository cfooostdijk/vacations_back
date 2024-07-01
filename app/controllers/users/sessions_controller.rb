# frozen_string_literal: true

module Users
  # Controller for managing sessions.
  class SessionsController < Devise::SessionsController
    include RackSessionFix
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      token = request.env['warden-jwt_auth.token']

      if request.method == 'POST' && resource.persisted?
        render_login_success(resource, token)
      elsif request.method == 'DELETE'
        render_logout_success
      else
        render_login_failure(resource)
      end
    end

    def respond_to_on_destroy
      current_user ? render_logout_success : render_session_not_found
    end

    def render_login_success(resource, token)
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        token:
      }, status: :ok
    end

    def render_logout_success
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    end

    def render_login_failure(resource)
      render json: {
        status: { code: 401, message: "Couldn't log in. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unauthorized
    end

    def render_session_not_found
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
