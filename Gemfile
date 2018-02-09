source "https://rubygems.org"

ruby '2.5.0'

gem "decidim", "~> 0.9.2"
gem "virtus-multiparams"

gem 'puma'
gem 'uglifier'
gem 'faker'
gem "passenger"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev"
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
end

group :production do
  gem "rails_12factor"
  gem "fog-aws"
  gem 'dalli'
  gem 'sendgrid-ruby'
  gem 'newrelic_rpm'
  gem "lograge"
  gem "sentry-raven"
  gem "sidekiq"
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
