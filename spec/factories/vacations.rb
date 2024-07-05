# frozen_string_literal: true

# spec/factories/vacations.rb
FactoryBot.define do
  factory :vacation do
    association :employee
    file_number { Faker::Number.unique.number(digits: 5) }
    vacation_start { Faker::Date.backward(days: 14) }
    vacation_end { Faker::Date.forward(days: 14) }
    motive { Faker::Lorem.sentence }
    status { Faker::Lorem.word }
    kind { Faker::Lorem.word }
  end
end
