# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    # Añade otros atributos según sea necesario
  end
end
