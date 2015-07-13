# ------------------------------------------------------------------------------
# View all Links
# ------------------------------------------------------------------------------
get "/all_links" do
  erb :"links/all_links"
end

# ------------------------------------------------------------------------------
# Add new assignment
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to the user
get "/add_assignment" do
  erb :"assignments/add_assignment"
end

# Step 2 - Save form information
get "/save_new_assignment" do
  @new_assignment = Assignment.new({"name" => params['assignments']['name'], "assignment_id" => params['assignments']['assignment_id'], "description" => params["assignments"]["description"], "where_stored" => params["assignments"]["where_stored"]})

  if @new_assignment.add_to_database
    erb :"assignments/success"
  else
    @error = true
    erb :"assignments/add_assignment"
  end
end

# ------------------------------------------------------------------------------
# Update assignment information
# ------------------------------------------------------------------------------
# Step 1 - Select assignment to Update
get "/edit_assignment" do
  erb :"assignments/edit_assignment"
end

# Step 2 - Display form for the user
get "/edit_assignment/:id" do
  @assignment_to_edit = Assignment.find(params["id"])
  erb :"assignments/edit_assignment_form"
end

# Step 3 - Saved changed information
get "/save_updated_assignment" do
  @assignment_to_edit = Assignment.find(params["assignments"]["id"])
  @assignment_to_edit.name = params["assignments"]["name"]
  @assignment_to_edit.description = params["assignments"]["description"]
  @assignment_to_edit.where_stored = params["assignments"]["where_stored"]

  saved_assignment = @assignment_to_edit.save_valid

  if (saved_assignment != false) && (!params["assignments"].nil?)
    erb :"assignments/success"
  else
    @assignment_to_edit
    @error = true
    erb :"assignments/edit_assignment_form"
  end
end

# ------------------------------------------------------------------------------
# Delete an assignment
# ------------------------------------------------------------------------------
# Step 1 - Select an assignment to delete
get "/delete_assignment" do
  erb :"assignments/delete_assignment"
end

# Step 2 - Confirm assignment deletion
get "/delete/:id" do
  @assignment_to_delete = Assignment.find(params["id"])
  erb :"assignments/confirm_delete"
end

# Step 3 - Delete
get "/really_delete" do
  if params["assignments"]["confirm_delete"] == "yes"
    assignment_to_delete = Assignment.find(params["assignments"]["id"])
    assignment_to_delete.delete
    erb :"assignments/delete_success"
  else
    erb :"index"
  end
end
