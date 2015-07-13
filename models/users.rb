require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class User
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name

  # Creates a new User Object
  #
  # options - empty Hash
  #   id (optional) - Integer, Primary key
  #   name (optional) - String, user's name
  #
  # Returns User Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      User.add({"name" => "#{self.name}"})
    else
      false
    end
  end

  # Get all assignment names associated with an Object
  #
  # Returns an Array of Hashes
  def get_assignment_names
    results = DATABASE.execute("SELECT assignments.name FROM assignments JOIN collaborators ON assignments.id = collaborators.assignment_id WHERE collaborators.user_id = #{self.id};")
  end

  # Ensures that an updated Object has valid fields before saving
  #
  # Returns the Object if saved or false if save failed
  def save_valid
    if self.valid?
      self.save
    else
      false
    end
  end

  # Utility - Checks if the fields for a new Object are entered correctly
  #
  # Returns valid - true/false Boolean
  def valid?

    if self.name.nil? || self.name == ""
      valid = false
    end

    return valid
  end


end
