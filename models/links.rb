require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Link
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :assignment_id, :description, :where_stored

  # Creates a new Link Object
  #
  # options - empty Hash
  #   id (optional) - Integer, Primary key
  #   name (optional) - String, name of the assignment
  #   assignment_id (optional) - Integer, Foreign key from the assignments table
  #   description (optional) - String, assignment description
  #   where_stored (optional) - String, url for the link to github repository
  #
  # Returns Link Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @assignment_id = options["assignment_id"]
    @description = options["description"]
    @where_stored = options["where_stored"]
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Link.add({"name" => "#{self.name}", "assignment_id" => "#{self.assignment_id}", "description" => "#{self.description}", "where_stored" => "#{self.where_stored}"})
    else
      false
    end
  end

  # Method to return the assignment name for the assignment it's for
  #
  # Returns name value, String, from the names table
  def get_assignment_name
    result = DATABASE.execute("SELECT name FROM assignments WHERE id = #{@assignment_id}").first

    return result
  end

  # Ensures that an updated Link Object has valid fields before saving
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
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    if self.assignment_id.nil? || self.assignment_id == ""
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
