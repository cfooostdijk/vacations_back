# frozen_string_literal: true

# Represents a vacation record associated with an employee.
class Vacation < ApplicationRecord
  belongs_to :employee

  validates :file_number, :vacation_start, :vacation_end, :motive, :kind, presence: true

  scope :by_file_number, ->(file_number) { where(file_number: file_number) if file_number.present? }
  scope :by_vacation_start, ->(start_date) { where('vacation_start >= ?', start_date) if start_date.present? }
  scope :by_vacation_end, ->(end_date) { where('vacation_end <= ?', end_date) if end_date.present? }
  scope :by_motive, ->(motive) { where(motive: motive) if motive.present? }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_kind, ->(kind) { where(kind: kind) if kind.present? }
end
