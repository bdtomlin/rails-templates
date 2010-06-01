run 'rm README'
run 'touch README'
# run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm public/javascripts/*.js'
run 'mkdir public/javascripts/jquery'
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery/jquery-1.4.2.min.js"
run 'curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js'

gem 'devise', '1.1.rc1'

gem "rspec", "2.0.0.beta.9", :group => :test
gem "rspec-rails",      ">= 2.0.0.beta.9.1", :group => :test
gem "factory_girl", "1.2.5.beta1", :git => "git://github.com/thoughtbot/factory_girl.git", :branch => "fixes_for_rails3", :group => :test
gem "ZenTest", :group => :test
gem "autotest", :group => :test
gem "autotest-rails", :group => :test
gem "cucumber", :group => :test
gem "cucumber-rails", :group => :test
gem "database_cleaner", :group => :test
gem "capybara", :group => :test
gem "ruby-debug", :group => :test
run 'rails g rspec:install'
run 'rails g cucumber:skeleton --capybara --rspec'

run 'rm .gitignore'
file '.gitignore', <<-FILE
.bundle
log/*
tmp/**/*
db/*.sqlite3
*.DS_Store
coverage/*
*.swp
*.swo
FILE

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"


