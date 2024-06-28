class Vacation < ApplicationRecord
  belongs_to :employee

  validates :vacation_start, :vacation_end, :motive, :status, :kind, presence: true
end
