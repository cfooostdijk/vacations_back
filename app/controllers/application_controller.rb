# frozen_string_literal: true

# Controller for managing controllers.
class ApplicationController < ActionController::API
  before_action :authenticate_user!
end
