# Assignments API
This API is used to get information on Omaha Code School assignments. An assignment includes:

- Name
- Description
- Link to Github Repository

In addition, assignments can have collaborators from the class and links to media associated with them, such as a YouTube file or blog post.

Request results from the API are returned in JSON.

## Requests
List of requests and outcomes

~~~
/api/assignments
~~~
Lists all assignments

~~~
/api/assignments/:id
~~~
Enter the actual number of the id at the end. Returns the specific assignment information, associated media, and collaborators.

~~~
/api/links
~~~
Returns all media information for all assignments.

~~~
/api/collaborators
~~~
Returns all collaborators I've worked with on OCS assignments.

~~~
/api/collaborators/:id
~~~
Enter the actual id of the collaborator in the request. Returns the collaborator and all assignments they have collaborated on.

~~~
/api/create_assignment/:name/:description/:where_stored
~~~
Adds a new assignment. In this request, actual information is entered for the assignment name, description, and link to Github Repository. The request returns the new assignment created.

~~~
/api/delete_assignment/:assignment_id
~~~
Deletes an assignment. Enter the actual assignment id number in the request. Returns the remaining assignments.

~~~
/api/add_link_to_assignment/:name/:assignment_id/:description/:where_stored
~~~
Adds a media link to an assignment. Actual information is put in for the name of the media link, link description, and the url where the link is at. Ensure that assignment_id matches an actual assignment. Returns the assignment information and it's associated media links.

~~~
/api/delete_link/:assignment_id/:link_id
~~~
Deletes a media link from an assignment. Enter an existing assignment id and an existing link id. Returns the assignment information and it's remaining media links.

~~~
/api/add_collaborator/:assignment_id/:user_id
~~~
Adds a collaborator to an assignment. Enter an existing assignment's id and an existing user's id to the request. Returns the assignment information and the collaborators for the assignment.

~~~
/api/delete_collaborator/:assignment_id/:user_id
~~~
Deletes a collaborator from an assignment. Enter an existing assignment id and user id. Returns the assignment information and the collaborators for the assignment.
