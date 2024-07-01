# frozen_string_literal: true

# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:lider) }
  end
end
