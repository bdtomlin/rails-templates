def append_to(file, content)
  run %{ echo "#{content}" >> #{file} }
end

run 'rm README'
run 'touch README'
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm public/javascripts/*.js'
run 'mkdir public/javascripts/jquery'
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery/jquery-1.4.2.min.js"
run 'curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js'

gem 'bson_ext'
gem 'mongo_mapper'
gem 'haml'


gem "rspec", "2.0.0.beta.12", :group => :test
gem "rspec-rails",      ">= 2.0.0.beta.12", :group => :test
gem "factory_girl", :group => :test
gem "ZenTest", :group => :test
gem "autotest", :group => :test
gem "autotest-rails", :group => :test
gem "cucumber", :group => :test
gem "cucumber-rails", :group => :test
gem "capybara", :group => :test

# run "bundle install"

run 'rails g rspec:install'
run 'rails g cucumber:install --capybara --rspec --skip-database'

run "mv spec/spec_helper.rb spec/spec_helper.rb.example"

file "spec/spec_helper.rb",
'
ENV["RAILS_ENV"] ||= "test"
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require "rspec/rails"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.after(:all) { MongoMapper.database.collections.each {|c| c.remove} }
end
'

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
