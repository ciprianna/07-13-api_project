require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Collaborator
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :assignment_id, :user_id

  # Creates a new Collaborator Object
  #
  # options - empty Hash
  #   id (optional) - Integer, Primary key
  #   assignment_id (optional) - Integer, Foreign key from the assignments table
  #   user_id (optional) - Integer, foreign key from the users table
  #
  # Returns Collaborator Object
  def initialize(options = {})
    @id = options["id"]
    @assignment_id = options["assignment_id"]
    @user_id = options["user_id"]
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Collaborator.add({"assignment_id" => "#{self.assignment_id}", "user_id" => "#{self.user_id}"})
    else
      false
    end
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

    if self.assignment_id.nil? || self.assignment_id == ""
      valid = false
    end

    if self.user_id.nil? || self.user_id == ""
      valid = false
    end

    return valid
  end


end
