class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy

  validates :first_name, :last_name, :email, :lider, presence: true

  scope :by_first_name, ->(first_name) { where("first_name LIKE ?", "%#{first_name}%") if first_name.present? }
  scope :by_last_name, ->(last_name) { where("last_name LIKE ?", "%#{last_name}%") if last_name.present? }
  scope :by_email, ->(email) { where("email LIKE ?", "%#{email}%") if email.present? }
  scope :by_lider, ->(lider) { where(lider: lider) if lider.present? }
end
