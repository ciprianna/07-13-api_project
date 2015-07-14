# ------------------------------------------------------------------------------
# View all Links
# ------------------------------------------------------------------------------
get "/all_links" do
  erb :"links/all_links"
end

# ------------------------------------------------------------------------------
# Add new link
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to the user
get "/add_link" do
  erb :"links/add_link"
end

# Step 2 - Save form information
get "/save_new_link" do
  @new_link = Link.new({"name" => params['links']['name'], "assignment_id" => params['links']['assignment_id'], "description" => params["links"]["description"], "where_stored" => params["links"]["where_stored"]})

  if @new_link.add_to_database
    erb :"links/success"
  else
    @error = true
    erb :"links/add_link"
  end
end

# ------------------------------------------------------------------------------
# Delete a link from an assignment
# ------------------------------------------------------------------------------
# Step 1 - Find the assignment to delete a link from
get "/delete_link" do
  erb :"links/delete_link"
end

# Step 2 - Display assignment collaborators to choose which one to delete
get "/delete_link/:id" do
  @assignment = Assignment.find(params["id"].to_i)
  erb :"links/choose_link"
end

# Step 3 - Delete collaboration from database
get "/delete_link_from_assignment" do
  link_to_delete = Link.find(params['link']['id'].to_i)

  link_to_delete.delete

  erb "Deleted!"
end
