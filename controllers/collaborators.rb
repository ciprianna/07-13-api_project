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
  # @new_collaborator = Link.new({"name" => params['links']['name'], "assignment_id" => params['links']['assignment_id'], "description" => params["links"]["description"], "where_stored" => params["links"]["where_stored"]})
  #
  # if @new_link.add_to_database
  #   erb :"links/success"
  # else
  #   @error = true
  #   erb :"links/add_link"
  # end
end
