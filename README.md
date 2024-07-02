# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

You will need this Ruby version and Rails version:
  * ruby 3.3.0 / Rails 7.1.3.4

* Download repository:
  git clone git@github.com:cfooostdijk/vacations_back.git

* System dependencies
  bundle install

* Configuration
  * Get your secret_key_base:
    rails secret

  * Set your secret_key_base at credentials:
    EDITOR="nano" bin/rails credentials:edit

  * Write and Save in "nano"
    secret_key_base: <YOUR RAILS SECRET>

* Database creation and initialization
  rails db:create

* How to run the test suite
  rspec

* How to run rubocop
  rubocop

* Make it run
  * Go to Gemfile and unlock gem:
    gem "rack-cors"

  * Go to cors and overwrite it with this:
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3001'

        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

  * Then go to your terminal and:
  rails s

* Its an API rails, so go get Postman and import collection in public/postman_collection:
  HAVE FUN !!!!!

* Or... much better go to:
  https://vacationsfront.netlify.app/
