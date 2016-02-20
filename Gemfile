source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.4'
gem 'rails-api'

gem 'pg'

gem 'active_model_serializers', '~> 0.10.0.rc4'
gem 'doorkeeper', '~> 3.1'
gem 'figaro'
gem 'marmite', github: 'nickpellant/marmite'
gem 'money-rails', '1.6'
gem 'pundit', '~> 1.1'
gem 'rack-cors', require: 'rack/cors'
gem 'statesman', '~> 2.0'
gem 'stripe', '~> 1.36'

group :development, :test do
  gem 'rubocop', require: false, github: 'bbatsov/rubocop'
  gem 'rspec-rails', '~> 3.3'
end

group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end
