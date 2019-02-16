source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'bootsnap',           '>= 1.1.0', require: false
gem 'factory_bot_rails',  '~> 5.0.1'
gem 'faker',              '~> 1.9.3'
gem 'grape',              '~> 1.2.3'
gem 'pg',                 '>= 0.18', '< 2.0'
gem 'puma',               '~> 3.11'
gem 'rails',              '~> 5.2.2'
gem 'rails_event_store',  '~> 0.36.0'
gem 'rspec-rails',        '~> 3.8.2'
gem 'rubocop',            '~> 0.64.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails',         '~> 0.3.9'
  gem 'pry-remote',        '~> 0.1.8'
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'simplecov',        '~> 0.16.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
