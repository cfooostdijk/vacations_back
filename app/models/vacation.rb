# frozen_string_literal: true

# Represents a vacation record associated with an employee.
class Vacation < ApplicationRecord
  belongs_to :employee

  validates :vacation_start, :vacation_end, :motive, :status, :kind, presence: true

  scope :by_status, ->(status) { where(status:) if status.present? }
  scope :by_kind, ->(kind) { where(kind:) if kind.present? }
  scope :by_vacation_start, ->(start_date) { where('vacation_start >= ?', start_date) if start_date.present? }
  scope :by_vacation_end, ->(end_date) { where('vacation_end <= ?', end_date) if end_date.present? }
end
