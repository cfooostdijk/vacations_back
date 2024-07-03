# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

# Kaminari is a scope and engine based, clean, powerful, and customizable paginator for modern web apps
gem 'kaminari'

# Faker is a library for generating fake data such as names, addresses, and phone numbers.
gem 'faker'

# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'

# Devise JWT adds JWT token support to Devise for token-based authentication.
gem 'devise-jwt'

# JSONAPI::Serializer is a fast and simple serializer for producing JSON:API compliant output.
gem 'jsonapi-serializer'

gem 'roo'

gem 'active_model_serializers'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # RuboCop is a Ruby static code analyzer and formatter, based on the community Ruby style guide.
  gem 'rubocop'

  # RSpec-Rails is a testing framework for Rails applications,
  # providing tools to write and run tests for models, controllers, views, and other components.
  gem 'rspec-rails'

  # Shoulda Matchers provides RSpec-compatible matchers for testing common Rails functionalities,
  # including ActiveRecord associations and validations.
  gem 'shoulda-matchers'

  # factory_bot_rails provides integration between FactoryBot and Rails to simplify the creation
  # of model instances for testing purposes.
  gem 'factory_bot_rails'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
