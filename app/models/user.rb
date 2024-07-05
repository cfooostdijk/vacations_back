# frozen_string_literal: true

# Represents an user in the organization.
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_insensitive: true }

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
