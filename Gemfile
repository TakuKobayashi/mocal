source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.9'
# Use sqlite3 as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'jpbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'annotate'
gem 'kaminari'
gem 'activerecord-import'
gem 'execjs'

gem 'less-rails'

gem 'd3js-rails'

gem 'devise'
gem 'activeadmin', github: 'activeadmin'

#push通知など外部APIを使うときは非同期に処理にしてしまいたい
gem "delayed_job"
gem "delayed_job_active_record"

# デプロイ先でデーモンとして動かすのに必要
gem "daemons"

gem 'jpmobile'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

gem "koala", "~> 1.11.0rc"

#認証後twitterにtweetするためのもの
gem 'twitter'

gem 'httpclient'

#お手軽メンテナンスモード
gem 'turnout'

#エクセル操作
gem 'roo'

gem "paranoia", "~> 2.0"

gem 'whenever', :require => false

#jsにサーバーのパラメータを渡すことが出来るやつ
gem 'gon'

#画像認識API
gem 'rekognize'
gem 'ruby-opencv'

gem 'fastimage'

#音を扱うためのgem
gem 'wavefile'
gem 'streamio-ffmpeg'

#文字の類似度を計測するためのもの
gem 'levenshtein-ffi', :require => 'levenshtein'

group :test do
  gem 'spork'
  gem 'guard-spork'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

