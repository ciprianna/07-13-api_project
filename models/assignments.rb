require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Assignment
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :description, :where_stored

  # Creates a new Assignment Object
  #
  # options - empty Hash
  #   id (optional) - Integer, Primary key
  #   name (optional) - String, name of the assignment
  #   description (optional) - String, assignment description
  #   where_stored (optional) - String, url for the link to github repository
  #
  # Returns Assignment Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @description = options["description"]
    @where_stored = options["where_stored"]
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Assignment.add({"name" => "#{self.name}", "description" => "#{self.description}", "where_stored" => "#{self.where_stored}"})
    else
      false
    end
  end

  # Get all links associated with an Object
  #
  # Returns an Array of Link Objects
  def get_links
    results = DATABASE.execute("SELECT * FROM links WHERE assignment_id = #{@id}")

    store_results = []

    results.each do |hash|
      store_results << Link.new(hash)
    end

    return store_results
  end

  # Get all user names associated with an Object
  #
  # Returns an Array of Hashes
  def get_user_names
    results = DATABASE.execute("SELECT users.name FROM users JOIN collaborators ON users.id = collaborators.user_id WHERE collaborators.assignment_id = #{self.id};")
  end


  # Ensures that an updated Assignment Object has valid fields before saving
  #
  # Returns the Object if saved or false if save failed
  def save_valid
    if self.valid_save?
      self.save
    else
      false
    end
  end

  # Utility - Checks if the fields for a new Object are entered correctly
  #
  # Returns valid - true/false Boolean
  def valid?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    if self.description.nil? || self.description == ""
      valid = false
    end

    if self.where_stored.nil? || self.where_stored == ""
      valid = false
    end

    assignment_to_find = DATABASE.execute("SELECT name FROM assignments;")

    assignment_to_find.each do |names|
      if names["name"] == @name
        valid = false
      end
    end

    return valid
  end

  # Utility - Checks if the fields for a saved Object are entered correctly
  #
  # Returns valid - true/false Boolean
  def valid_save?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    if self.description.nil? || self.description == ""
      valid = false
    end

    if self.where_stored.nil? || self.where_stored == ""
      valid = false
    end

    return valid

  end

end
