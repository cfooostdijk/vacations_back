# frozen_string_literal: true

# Represents an employee in the organization.
class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy

  validates :file_number, :first_name, :last_name, :email, :lider, presence: true
  validates :email, :file_number, uniqueness: true

  scope :by_file_number, ->(file_number) { where(file_number:) if file_number.present? }
  scope :by_first_name, ->(first_name) { where('first_name LIKE ?', "%#{first_name}%") if first_name.present? }
  scope :by_last_name, ->(last_name) { where('last_name LIKE ?', "%#{last_name}%") if last_name.present? }
  scope :by_email, ->(email) { where('email LIKE ?', "%#{email}%") if email.present? }
  scope :by_lider, ->(lider) { where(lider:) if lider.present? }
end
