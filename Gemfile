source 'https://rubygems.org'

gem 'rails', '3.2.10'
gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'jquery-rails', '2.1.3'
gem 'ancestry'
gem 'rails_autolink'
gem 'thin'
gem 'devise'
gem 'will_paginate', '3.0.3'
gem 'omniauth-facebook'
gem 'paperclip'
gem 'aws-s3'
gem 'aws-sdk'
gem 'delayed_job_active_record'
gem 'daemons'
gem "remotipart"

#Windows development only
#gem 'eventmachine', '1.0.0.beta.4.1'

# Performance testing gems - do not enable in production!!
#gem 'query_reviewer', :git => 'git://github.com/nesquena/query_reviewer.git'
#gem 'bullet'

group :production, :staging do
  gem 'pg' #for Heroku deployment
end

group :development, :test do
  #gem 'sqlite3'
  #gem 'mysql'
  gem 'pg'
end


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
