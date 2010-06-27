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

gem "mongoid", "2.0.0.beta7"
gem "bson_ext", "1.0.1"

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
gem "launchy", :group => :test

run "bundle install"

run "rails generate mongoid:config"
run 'rails g rspec:install'
run 'rails g cucumber:install --capybara --rspec --skip-database'

file 'features/support/env.custom.rb', %{
ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

Before { Mongoid.master.collections.each(&:drop) }
}

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
