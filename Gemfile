# frozen_string_literal: true

source 'https://rubygems.org'

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "release/0.24-stable" }

gem 'decidim', DECIDIM_VERSION
gem 'decidim-consultations', DECIDIM_VERSION
gem 'decidim-file_authorization_handler',
    git: 'https://github.com/MarsBased/decidim-file_authorization_handler.git',
    branch: 'master'
gem 'decidim-initiatives', DECIDIM_VERSION
gem 'decidim-term_customizer',
    git: 'https://github.com/mainio/decidim-module-term_customizer.git'
gem 'virtus-multiparams'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'geocoder', '~> 1.6.1'

gem 'faker'
gem 'puma'
gem 'sprockets', '~> 3.7.2'
gem 'uglifier'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'decidim-dev', DECIDIM_VERSION
end

group :development do
  gem 'launchy'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end

group :production do
  gem 'dalli'
  gem 'fog-aws'
  gem 'lograge'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'sendgrid-ruby'
  gem 'sentry-raven'
  gem 'sidekiq'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
