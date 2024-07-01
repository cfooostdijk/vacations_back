# frozen_string_literal: true

# spec/factories/vacations.rb
FactoryBot.define do
  factory :vacation do
    vacation_start { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    vacation_end { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    motive { Faker::Lorem.sentence }
    # status { Vacation.statuses.keys.sample }
    # kind { Vacation.kinds.keys.sample }
    status { Faker::Lorem.sentence }
    kind { Faker::Lorem.sentence }
    association :employee, factory: :employee
  end
end
