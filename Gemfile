source 'https://rubygems.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml-rails', '>= 0.3.4'

gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem 'omniauth-twitter'

gem "figaro", ">= 0.5.3"
gem 'bootstrap-sass'
gem 'simple_form'

gem 'newrelic_rpm'
gem 'ransack'

group :development do
  gem "quiet_assets", ">= 1.0.1", :group => :development
  gem "better_errors", ">= 0.3.2", :group => :development
  gem "binding_of_caller", ">= 0.6.8", :group => :development
  gem 'html2haml'
end

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails", ">= 2.12.2"
  gem "factory_girl_rails", ">= 4.2.0"
end

group :test do
  gem "database_cleaner", ">= 0.9.1"
  gem "email_spec", ">= 1.4.0"
  gem "cucumber-rails", ">= 1.3.0", :require => false
  gem "launchy", ">= 2.1.2"
  gem "capybara", ">= 2.0.2"
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg'
  gem 'thin'
end

