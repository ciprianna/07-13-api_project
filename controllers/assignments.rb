# ------------------------------------------------------------------------------
# View all Assignments
# ------------------------------------------------------------------------------
get "/all_assignments" do
  erb :"assignments/all_assignments"
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
