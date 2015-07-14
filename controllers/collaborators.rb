# ------------------------------------------------------------------------------
# View all collaborators
# ------------------------------------------------------------------------------
get "/all_collaborators" do
  erb :"collaborators/all_collaborators"
end

# ------------------------------------------------------------------------------
# Add new collaborator
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to the user
get "/add_collaborator" do
  erb :"collaborators/add_collaborator"
end

# Step 2 - Save form information
get "/save_new_collaborator" do
  @new_collaborator = Collaborator.new({"user_id" => params['collaborators']['user_id'], "assignment_id" => params['collaborators']['assignment_id']})

  if @new_collaborator.add_to_database
    erb :"collaborators/success"
  else
    @error = true
    erb :"collaborators/add_collaborator"
  end
end
