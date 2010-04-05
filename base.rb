# load_template "path/to/another/template"

############## gem commands #################
gem 'thoughtbot-shoulda', :lib => 'shoulda'
gem 'factory_girl'
gem 'haml'
gem 'cucumber'
gem 'seess'

rake 'gems:install'

# prompt for something
if yes?("Do you want to...")
  # the stuff you wanted to do
  puts "you wanted to..."
end

# to get input from user
# var = ask('My question here?')

# then you can do whatever you want with the var.

##############  commands #################
run 'haml .'
run "echo TODO > README"
run "rm public/javascripts/*.js"
run "touch public/javascripts/application.js"
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.min.js"
run "curl -L http://code.jquery.com/jquery-1.4.2.js > public/javascripts/jquery.js"

git :init

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/database_example.yml"

file '.gitignore', <<-END
config/database.yml
log/*
tmp/**/*
db/schema.rb
db/*.sqlite3
public/system
*.DS_Store
coverage/*
*.swp
*.swo
END

git :add => "."
git :commit => "-m 'initial commit'"
