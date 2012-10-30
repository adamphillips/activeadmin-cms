$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin-cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-cms"
  s.version     = ActiveadminCms::VERSION
  s.authors     = ["Adam Phillips"]
  s.email       = ["adam@29ways.co.uk"]
  s.homepage    = "https://github.com/adamphillips/activeadmin-cms"
  s.summary     = "Adds CMS functionality to ActiveAdmin"
  s.description = "Converts ActiveAdmin into a simple CMS"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "activeadmin"

  s.add_dependency "haml"

  s.add_dependency "formtastic"

  s.add_dependency "carrierwave"
  s.add_dependency "fog"
  s.add_dependency "mini_magick"
  s.add_dependency "acts_as_markup"
  s.add_dependency "delayed_job_active_record"
  s.add_dependency "carrierwave_backgrounder"
  s.add_dependency "daemons"
  
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency "webrat"
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'generator_spec'
   
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"

  s.add_development_dependency 'simplecov'
 
  s.add_development_dependency 'wirble'
  s.add_development_dependency 'console_update'
  # Documenting
  s.add_development_dependency 'yard'
  s.add_development_dependency 'yard-rest-plugin'
  s.add_development_dependency 'yard-rails'
  s.add_development_dependency 'yard-rspec'
  s.add_development_dependency 'yard-examples-from-rspec'
  s.add_development_dependency 'yard-spellcheck'

end
