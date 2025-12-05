source "https://rubygems.org"

ruby RUBY_VERSION
DECIDIM_VERSION = "0.29.7"

gem "decidim", DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/PopulateTools/decidim-module-term_customizer", branch: "upgrade_0.29"
gem "decidim-calendar", git: "https://github.com/decidim-ice/decidim-module-calendar", branch: "release/0.29-stable"
gem "decidim-decidim_awesome", "~> 0.12.6"
gem "decidim-templates", DECIDIM_VERSION

gem 'puma'
gem 'uglifier'
gem 'faker'

gem "execjs", "~> 2.9.0"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem 'letter_opener_web'
  gem 'listen'
  gem 'spring-commands-rspec'
  gem 'launchy'
end

group :production, :straging do
  gem "rails_12factor"
  gem "fog-aws"
  gem "aws-sdk-s3", require: false
  gem "dalli"
  gem 'sendgrid-ruby'
  gem 'newrelic_rpm'
  gem "lograge"
  gem "sentry-raven"
  gem "sidekiq", "~> 6.5.6"
end

group :test do
  gem "rspec-rails"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
