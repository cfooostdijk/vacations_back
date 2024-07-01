# frozen_string_literal: true

# app/controllers/concerns/rack_session_fix.rb
module RackSessionFix
  extend ActiveSupport::Concern
  # Fix for sessions devise.
  class FakeRackSession < Hash
    def enabled?
      false
    end
  end
  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
