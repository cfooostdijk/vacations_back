<!-- GETTING STARTED -->
## Getting Started

This is a guide to this proyect, its a two repository proyect.
This one is an API Rails Backend.


### Prerequisites

* You will need at least Ruby 3.3.0 and Rails 7.1.3.4


### Installation

1. Clone the repo
   ```
   git clone git clone git@github.com:cfooostdijk/vacations_back.git
   ```
2. Install gems
   ```
   bundle install
   ```
3. Configuration
   * Get your secret_key_base
     ```
     rails secret
     ```
   * Set your secret_key_base at `credentials`
     ```
     EDITOR="nano" bin/rails credentials:edit
     ```
   * Write and save it in "nano"
     ```
     EDITOR="nano" bin/rails credentials:edit
     ```
4. Database creation and initialization
   ```
   rails db:create
   ```
5. How to run the test suite
   ```
   rspec
   ```
6. How to run rubocop
   ```
   rubocop
   ```
7. Set CORS
   * Go to Gemfile and unlock gem
     ```
     gem 'rack-cors'
     ```
   * Go to `config/initializers/cors.rb` and overwrite it with this
     ```
      Rails.application.config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins 'http://localhost:3001'

          resource "*",
            headers: :any,
            methods: [:get, :post, :put, :patch, :delete, :options, :head]
        end
      end
     ```
8. Then go to your terminal and make it run
   ```
   rails s
   ```
### USE

1. Go to your excel file and download it as xsls

2. Go to "import file" at website and import

3. Enjoy data on tabs



* Its an API rails, so go get Postman and import collection in public/postman_collection --->  HAVE FUN !!!!!

* Or follow the frontend installation here: `https://github.com/cfooostdijk/vacations_front`

* Or... much better go to:  `https://vacationsfront.netlify.app`
