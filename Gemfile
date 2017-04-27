source "https://rubygems.org"

ruby '2.4.1'

gem "decidim", git: "https://github.com/AjuntamentdeBarcelona/decidim.git"

gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'faker', '~> 1.7.3'
gem "passenger"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", git: "https://github.com/AjuntamentdeBarcelona/decidim.git"
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
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
