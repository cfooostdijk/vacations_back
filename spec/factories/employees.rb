# frozen_string_literal: true

# spec/factories/employees.rb
FactoryBot.define do
  factory :employee do
    file_number { Faker::Number.unique.number(digits: 5) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    lider { true }
  end
end
