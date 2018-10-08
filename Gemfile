source "https://rubygems.org"

ruby '2.5.0'

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim.git", branch: "0.14-stable" }

gem "decidim", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-file_authorization_handler", git: "https://github.com/CodiTramuntana/decidim-file_authorization_handler.git", branch: "fix/ensure_all_data_properly_encoded"
gem "virtus-multiparams"

gem 'puma'
gem 'uglifier'
gem 'faker'
gem "passenger"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem 'launchy'
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
