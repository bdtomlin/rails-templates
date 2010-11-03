run 'rm README'
run 'touch README.rdoc'
run 'rm public/index.html'
run 'rm public/images/rails.png'

gem "haml"
gem "hpricot" # for turning devise views into haml
gem "devise"
gem "ruby_parser"
gem 'jquery-rails'

gem "shoulda", :group => :test
gem "rspec-rails", ">= 2.0.0.rc", :group => :test
gem "factory_girl_rails", :group => :test
gem "ZenTest", :group => :test
gem "autotest", :group => :test
gem "autotest-rails", :group => :test
gem "capybara", :group => :test
gem "cucumber-rails", :group => :test
gem "launchy", :group => :test
gem "email_spec", :group => :test

run "bundle install"

run "rails generate jquery:install"

run "rails generate email_spec:steps"
email_steps_path = 'features/step_definitions/email_steps.rb'
email_steps_content = File.read(email_steps_path)
run "rm #{email_steps_path}"
file email_steps_path, %{require 'email-spec'
World(EmailSpec::Helpers)
#{email_steps_content}
}

run 'rails g rspec:install'
run 'rails g cucumber:install --capybara --rspec'

run 'rm app/views/layouts/application.html.erb'

run "rails generate devise:install"

application %{
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false
    end
}

plugin 'dynamic_form', :git => "git://github.com/rails/dynamic_form.git"

run 'rm .gitignore'
file '.gitignore',
%{
.bundle
db/*.sqlite3*
log/*.log
*.log
tmp/**/*
tmp/*
doc/api
doc/app
*.swp
*.swo
*~
.DS_Store
coverage/*
}

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"

