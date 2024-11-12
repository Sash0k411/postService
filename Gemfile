source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

gem "devise"

gem "pundit"

gem "active_storage_validations"

gem "delayed_job_active_record"

gem "axlsx"
gem "caxlsx_rails"

gem "jquery-rails"
gem "stimulus-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  gem "rspec-rails", "~> 5.0"
end

group :development do
  gem "annotate"
  gem "letter_opener"
end

group :production do
  gem "rack-timeout"
end
