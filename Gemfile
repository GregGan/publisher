source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '2.7.2'

if ENV['BUNDLE_DEV']
  gem 'gds-sso', path: '../gds-sso'
else
  gem 'gds-sso', '~> 11.2'
end

if ENV['CONTENT_MODELS_DEV']
  gem "govuk_content_models", :path => '../govuk_content_models'
else
  gem "govuk_content_models", "~> 42.0.1"
end

if ENV['API_DEV']
  gem 'gds-api-adapters', path: '../gds-api-adapters'
else
  gem 'gds-api-adapters', '~> 38.0.0'
end

gem 'erubis'
gem 'govuk_admin_template', '4.2.0'
gem 'select2-rails', '3.5.9.1'
gem 'jquery-ui-rails', '~> 5.0.3'
gem 'selectize-rails', '0.12.1'
gem 'momentjs-rails', '2.8.3'
gem 'formtastic', '2.3.0'
gem 'formtastic-bootstrap', '3.0.0'
gem 'rails_autolink', '1.1.6'
gem 'mousetrap-rails', '1.4.6'

gem "nested_form", git: 'https://github.com/alphagov/nested_form.git', branch: 'add-wrapper-class'

if ENV['GOVSPEAK_DEV']
  gem 'govspeak', path: '../govspeak'
else
  gem 'govspeak', '~> 3.4.0'
end

gem 'has_scope'
gem 'inherited_resources'
gem 'kaminari', '0.13.0'
gem 'bootstrap-kaminari-views', '0.0.3'
gem 'logstasher', '0.4.8'
gem "mongoid_rails_migrations", "1.0.0"
gem "mongoid-sadstory"
gem 'null_logger'
gem 'plek', '1.9.0'
gem 'diffy', '3.0.6'

gem 'mlanett-redis-lock', '0.2.2' # Only used in some importers
gem 'rest-client', require: false # Only used in some importers
gem 'retriable', require: false # Only used in some importers
gem 'reverse_markdown', '0.3.0', require: false # Only used in some importers

gem 'statsd-ruby', '~> 1.1.0', require: false
gem 'whenever', require: false

gem 'unicorn', '4.3.1'

gem 'airbrake', '3.1.15'
gem 'govuk_sidekiq', '0.0.4'

group :test do
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'shoulda', '3.5.0'
  gem 'database_cleaner', '1.5.1'

  gem 'capybara', '2.6.2'
  gem 'poltergeist', '1.5.0'
  gem 'launchy', '2.1.1'
  gem 'rails-perftest'
  gem 'ruby-prof'

  gem 'webmock', '~> 1.22'
  gem 'mocha', '1.1.0'
  gem 'factory_girl_rails'

  gem "timecop", '0.4.4'

  gem 'govuk-content-schema-test-helpers', '~> 1.4'

  gem 'simplecov', '~> 0.6.4', :require => false
  gem 'simplecov-rcov', '~> 0.2.3', :require => false
  gem 'ci_reporter_minitest', '1.0.0'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'jasmine', '2.1.0'
  gem 'govuk-lint', '~> 0.7'
  gem 'ci_reporter_rspec'
end

