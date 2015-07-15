# ------------------------------------------------------------------------------
# Display all assignments in json
# ------------------------------------------------------------------------------
get "/api/assignments" do
  @assignments = Assignment.all_hash
  json @assignments
end

# ------------------------------------------------------------------------------
# Display one assignment's information in json
# ------------------------------------------------------------------------------
get "/api/assignments/:id" do
  selected_assignment = Assignment.find(params["id"])
  @assignment = selected_assignment.to_hash

  @assignment["collaborators"] = []
  selected_assignment.get_user_names.each do |collaborator|
    @assignment["collaborators"] << collaborator.to_hash
  end

  @assignment["links"] = []

  selected_assignment.get_links.each do |link|
    @assignment["links"] << link.to_hash
  end

  json @assignment
end

# ------------------------------------------------------------------------------
# Display all links in json
# ------------------------------------------------------------------------------
get "/api/links" do
  @links = Link.all_hash
  json @links
end

# ------------------------------------------------------------------------------
# Display all collaborators in json
# ------------------------------------------------------------------------------
get "/api/collaborators" do
  @collaborators = User.all_hash
  json @collaborators
end

# ------------------------------------------------------------------------------
# Display one collaborater and their assignments worked on in json
# ------------------------------------------------------------------------------
get "/api/collaborators/:id" do
  selected_user = User.find(params["id"])
  @users = selected_user.to_hash

  @users["assignments"] = []
  selected_user.get_assignment_names.each do |assignment|
    @users["assignments"] << assignment.to_hash
  end

  json @users
end

# ------------------------------------------------------------------------------
# Create new assignment
# ------------------------------------------------------------------------------
# get "/api/create_assignment" do
#   @add_from_api = true
#   erb :"assignments/add_assignment"
# end

get "/api/create_assignment/:name/:description/:where_stored" do
  new_assignment = Assignment.new({"name" => params['name'], "description" => params['description'], "where_stored" => params['where_stored']})

  assignment_added = new_assignment.add_to_database

  if assignment_added != false
    @new_assignment_hash = assignment_added.to_hash
    json @new_assignment_hash
  else
    erb "Addition failed."
  end
end

# ------------------------------------------------------------------------------
# Add a link to an assignment
# ------------------------------------------------------------------------------
get "/api/add_link_to_assignment/:name/:assignment_id/:description/:where_stored" do
  # Create the new Link Object
  new_link = Link.new({"name" => params['name'], "assignment_id" => params['assignment_id'], "description" => params['description'], "where_stored" => params['where_stored']})

  # Try to add to database (if valid)
  link_added = new_link.add_to_database

  # Find the associated assignment and store all of its info
  selected_assignment = Assignment.find(params["assignment_id"])
  @assignment = selected_assignment.to_hash

  # Store all collaborators for that assignment
  @assignment["collaborators"] = []
  selected_assignment.get_user_names.each do |collaborator|
    @assignment["collaborators"] << collaborator.to_hash
  end

  # Store all links (including the new one) in the hash
  @assignment["links"] = []
  selected_assignment.get_links.each do |link|
    @assignment["links"] << link.to_hash
  end

  # If new link was actually added to the database, return JSON
  if link_added != false
    json @assignment
  else
    erb "Addition failed."
  end
end

# ------------------------------------------------------------------------------
# Add collaborator to an assignment
# ------------------------------------------------------------------------------
get "/api/add_collaborator/:assignment_id/:user_id" do
  new_collaboration = Collaborator.new({"assignment_id" => params['assignment_id'], "user_id" => params['user_id']})

  collaboration_added = new_collaboration.add_to_database

  # Find the associated assignment and store all of its info
  selected_assignment = Assignment.find(params["assignment_id"])
  @assignment = selected_assignment.to_hash

  @assignment["collaborators"] = []
  selected_assignment.get_user_names.each do |collaborator|
    @assignment["collaborators"] << collaborator.to_hash
  end

  @assignment["links"] = []
  selected_assignment.get_links.each do |link|
    @assignment["links"] << link.to_hash
  end

  # If new collaboration was actually added to the database, return JSON
  if collaboration_added != false
    json @assignment
  else
    erb "Addition failed."
  end
end

# ------------------------------------------------------------------------------
# Remove a collaborator from an assignment
# ------------------------------------------------------------------------------
get "/api/delete_collaborator/:assignment_id/:user_id" do
  collaboration_to_delete = Collaborator.get_collaboration(params['assignment_id'], params['user_id'])

  collaboration_to_delete.delete

  selected_assignment = Assignment.find(params["assignment_id"])
  @assignment = selected_assignment.to_hash

  @assignment["collaborators"] = []
  selected_assignment.get_user_names.each do |collaborator|
    @assignment["collaborators"] << collaborator.to_hash
  end

  json @assignment
end

# ------------------------------------------------------------------------------
# Remove a link from an assignment
# ------------------------------------------------------------------------------
get "/api/delete_link/:assignment_id/:link_id" do
  link_to_delete = Link.find(params['link_id'])

  link_to_delete.delete

  selected_assignment = Assignment.find(params["assignment_id"])
  @assignment = selected_assignment.to_hash

  @assignment["links"] = []
  selected_assignment.get_links.each do |link|
    @assignment["links"] << link.to_hash
  end

  json @assignment
end

# ------------------------------------------------------------------------------
# Delete an assignment from the api
# ------------------------------------------------------------------------------
get "/api/delete_assignment/:assignment_id" do
  assignment_to_delete = Assignment.find(params["assignment_id"].to_i)
  assignment_to_delete.delete

  @assignments = Assignment.all_hash
  json @assignments
end

# ------------------------------------------------------------------------------
# Display all assignments
# ------------------------------------------------------------------------------
get "/api/all_assignments" do
  erb :"api/all_assignments"
end
