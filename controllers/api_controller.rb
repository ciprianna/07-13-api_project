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
