run 'rm README'
run 'touch README'
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm public/javascripts/*.js'
run 'mkdir public/javascripts/jquery'
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery/jquery-1.4.2.min.js"
run 'curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js'

gem "haml"
gem "shoulda"
gem "rspec", "2.0.0.beta.12", :group => :test
gem "rspec-rails",      ">= 2.0.0.beta.12", :group => :test
gem "factory_girl", :group => :test
gem "factory_girl_rails", :group => :test
gem "ZenTest", :group => :test
gem "autotest", :group => :test
gem "autotest-rails", :group => :test
gem "cucumber", :group => :test
gem "cucumber-rails", :group => :test
gem "capybara", :group => :test
gem "launchy", :group => :test

db = ask("Press 1 for Mongoid and 2 for Active Record").to_i

if db == 1
  gem "mongoid", "2.0.0.beta7"
  gem "bson_ext", "1.0.1"
  gem 'mongo_ext'

  run "bundle install"

  run 'rails g rspec:install'
  run 'rails g cucumber:install --capybara --rspec --skip-database'

  file 'features/support/env.custom.rb', %{
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  Before { Mongoid.collections.each { |c| c.remove } }
  }
  run "rails generate mongoid:config"

elsif db == 2
  gem 'mysql'

  run "bundle install"

  run 'rails g rspec:install'
  run 'rails g cucumber:install --capybara --rspec'
end

run 'rm .gitignore'
file '.gitignore',
%{
.bundle
log/*
tmp/**/*
db/*.sqlite3
*.DS_Store
coverage/*
*.swp
*.swo
}

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"
