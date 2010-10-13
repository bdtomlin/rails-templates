run 'rm README'
run 'touch README'
run 'rm public/index.html'
run 'rm public/images/rails.png'

gem "haml"
gem "hpricot" # for turning devise views into haml
gem "devise"
gem "ruby_parser"
gem 'jquery-rails'
gem "html5-boilerplate"

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
run "compass init rails -r html5-boilerplate -u html5-boilerplate --force"

application %{
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false
    end
}

# to fix problem with Rack::Utils::EscapeUtils
#gem "escape_utils"
#file 'config/initializers/escape_utils_monkey_patch.rb',
#%{
#require 'escape_utils/html/rack' # to patch Rack::Utils
## commented out because they cause problems with links in emails
## require 'escape_utils/html/erb' # to patch ERB::Util
## require 'escape_utils/html/cgi' # to patch CGI
## require 'escape_utils/html/haml' # to patch Haml::Helpers

#module Rack
  #module Utils
    #def escape(s)
      #EscapeUtils.escape_url(s)
    #end
  #end
#end
#}
plugin 'dynamic_form', :git => "git://github.com/rails/dynamic_form.git"

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

