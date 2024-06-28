class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy

  validates :first_name, :last_name, :email, :lider, presence: true
end
