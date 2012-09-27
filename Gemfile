source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Gems only used in development environment.
group :development do
  gem 'sqlite3'
end

# Gems only used in production environment.
group :production do
  gem 'mysql2'

  # Use passenger as the app server
  gem 'passenger'

  # Authentication via Shibboleth
  gem 'omniauth'
  gem 'omniauth-shibboleth'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-tablesorter'

# Deploy with Capistrano
gem 'capistrano'

# For menu on the left
gem 'simple-navigation'

# CAMPUSonline web service access
gem 'httparty'

# To use debugger
gem 'debugger'
