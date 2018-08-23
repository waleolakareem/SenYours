source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Rails Generated Gems
gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'heroku-deflater', :group => :production, git: "https://github.com/romanbsd/heroku-deflater.git"
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
# Allows JQuery to be used in .js.erb files
gem 'jquery-ui-rails'
gem 'jquery-rails'
# Provides search functionality within database.
gem 'select2-rails'
# Emoji stuff. (╯°□°）╯︵ ┻━┻
gem 'rails_emoji_picker'
#Image Uploader & Maintainer
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
# Allows use of the `.env` file.
gem 'dotenv'
# Allows connection to cloud services such as AmazonS3, AWS, Azure.
gem 'fog', '1.42'
# Twillio API Connection.
gem 'twilio-ruby', '~> 5.7.2'
# Stripe API Connection
gem 'stripe'
# Check if provided number is real
gem 'phony_rails'
# Provides Model Validators
gem 'activevalidators', '~> 4.0.1'
# Allows particular fonts
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass', branch: 'v1.0beta'
# Encrypt database
gem "attr_encrypted", "~> 3.0.0"
# Provides County and Region information
gem 'carmen-rails', '~> 1.0.0'
# Provides names for countries, states, and cities.
gem 'city-state'
#redis for action cable in production
gem 'redis', '~> 3.3', '>= 3.3.1'
# Provides randomly generated fake data for testing purposes.
gem 'faker'
# Provides a rich text editor
gem 'ckeditor', github: 'galetahub/ckeditor'
# Creates multiple pages based on available database.``
gem 'will_paginate'
# Rails precompiler.
gem 'sprockets-rails', :require => 'sprockets/railtie'

group :development, :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
