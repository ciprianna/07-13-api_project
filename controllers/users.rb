# ------------------------------------------------------------------------------
# View all users
# ------------------------------------------------------------------------------
get "/all_users" do
  erb :"users/all_collaborators"
end

# ------------------------------------------------------------------------------
# Add new user
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to the user
get "/add_user" do
  erb :"users/add_user"
end

# Step 2 - Save form information
get "/save_new_user" do
  @new_user = User.new({"name" => params['user']['name']})

  if @new_user.add_to_database
    erb :"users/success"
  else
    @error = true
    erb :"users/add_user"
  end
end
