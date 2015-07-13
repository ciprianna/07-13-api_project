require "pry"
require "sinatra"
require "sinatra/reloader"
require "sinatra/json"

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

# Models
require_relative "models/assignments.rb"
require_relative "models/collaborators.rb"
require_relative "models/links.rb"
require_relative "models/users.rb"

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/assignments.rb"
require_relative "controllers/collaborators.rb"
require_relative "controllers/links.rb"
require_relative "controllers/users.rb"
require_relative "controllers/api_controller.rb"
