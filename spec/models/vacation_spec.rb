# frozen_string_literal: true

# spec/models/vacation_spec.rb
require 'rails_helper'

RSpec.describe Vacation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:vacation_start) }
    it { should validate_presence_of(:vacation_end) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:kind) }
  end

  describe 'associations' do
    it { should belong_to(:employee) }
  end
end
