run 'rm README'
run 'touch README'
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm public/javascripts/*.js'
run 'mkdir public/javascripts/jquery'
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery/jquery-1.4.2.min.js"
run 'curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js'

gem "haml"
gem "devise", ">=1.1.rc2"
gem "shoulda", :group => :test
gem "rspec-rails",      ">= 2.0.0.beta.19", :group => :test
gem "factory_girl_rails", :group => :test
gem "ZenTest", :group => :test
gem "autotest", :group => :test
gem "autotest-rails", :group => :test
gem "capybara", :group => :test
gem "cucumber-rails", :group => :test
gem "launchy", :group => :test

db = ask("1 for Mongoid, 2 for MongoMapper, 3 for Active Record: ").to_i

if db == 1
  gem "mongo", "1.0.4"
  gem "bson_ext", "1.0.4"
  gem "mongoid", "2.0.0.beta9"

  run "bundle install"

  run 'rails g rspec:install'
  run 'rails g cucumber:install --capybara --rspec --skip-database'

  file 'features/support/env.custom.rb', %{
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  Before { Mongoid.master.collections.each { |c| c.remove } }
  }
  run "rails generate mongoid:config"

elsif db == 2
  gem "mongo", "1.0.4"
  gem "bson_ext", "1.0.4"
  gem 'mongo_mapper'

  run "bundle install"

  run 'rails g rspec:install'
  run 'rails g cucumber:install --capybara --rspec --skip-database'

  file 'features/support/env.custom.rb', %{
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  MongoMapper.database.collections.each { |c| c.remove }
  }

elsif db == 3
  gem 'mysql'

  run "bundle install"

  run 'rails g rspec:install'
  run 'rails g cucumber:install --capybara --rspec'

end

run 'rm app/views/layouts/application.html.erb'
file "app/views/layouts/application.html.haml", %{
!!! 5
%html
  %head
    %title Site Title
    = stylesheet_link_tag :all
    = javascript_include_tag 'jquery/jquery-1.4.2.min.js'
    = javascript_include_tag 'rails.js'
    = csrf_meta_tag
  %body
    = yield
}

run "git clone git@github.com:bdtomlin/rails3_haml_scaffold_generator.git lib/generators/haml"
run "rails generate devise:install"

application %{
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false
    end
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
