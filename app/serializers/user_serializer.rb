# frozen_string_literal: true

# Represents a serialization of user in the organization.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at
end
