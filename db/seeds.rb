require 'faker'

employees = []
30.times do
  employees << Employee.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    lider: Faker::Name.first_name
  )
end

40.times do |i|
  Vacation.create(
    employee_id: employees[i % 30].id,
    vacation_start: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    vacation_end: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    kind: ['annual', 'sick'].sample,
    motive: Faker::Lorem.sentence(word_count: 2),
    status: ['approved', 'pending', 'denied'].sample
  )
end
