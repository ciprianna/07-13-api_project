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

# ------------------------------------------------------------------------------
# Delete a collaborator from an assignment
# ------------------------------------------------------------------------------
# Step 1 - Find the assignment to delete a collaboration from
get "/delete_collaborator" do
  erb :"collaborators/delete_collaborator"
end

# Step 2 - Display assignment collaborators to choose which one to delete
get "/delete_collaborator/:id" do
  @assignment = Assignment.find(params["id"].to_i)
  erb :"collaborators/choose_user"
end

# Step 3 - Delete collaboration from database
get "/delete_collaboration_from_assignment" do
  collaboration_to_delete = Collaborator.get_collaboration(params['collaborators']['assignment_id'].to_i, params['collaborators']['user_id'].to_i)

  collaboration_to_delete.delete

  erb "Deleted!"
end
