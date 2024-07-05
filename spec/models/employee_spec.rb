# frozen_string_literal: true

# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'associations' do
    it { should have_many(:vacations).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:file_number) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:lider) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:file_number) }
  end
end
