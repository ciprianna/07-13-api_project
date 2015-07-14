get "/api/assignments" do
  @assignments = Assignment.all_hash
  json @assignments
end

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

get "/api/links" do
  @links = Link.all_hash
  json @links
end

get "/api/collaborators" do
  @collaborators = User.all_hash
  json @collaborators
end

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
# Step 1 - Form to display to the user
get "/api/create_assignment" do
  @add_from_api = true
  erb :"assignments/add_assignment"
end

# Step 2 - Add it and then return the result as a json
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
