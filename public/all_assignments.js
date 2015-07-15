// Get the ul item to append
var all_assignments = document.getElementById('list');

// Make request for the api return for all assignments
var route = new XMLHttpRequest();
route.open("get", "/api/assignments");

// Run this function after request loads
route.addEventListener("load", function(){
  // Parse return results
  var parsed_all = JSON.parse(route.responseText);

  // Iterate through results and create a new list element for each one;
  //   Append to ul element; Create a link element; Append to new li element;
  //   Set the link path to the api route for a single assignment's information
  //   Set an attribute id for each link; Add an event listener for each link.
  for (i = 0; i < parsed_all.length; i++) {
    var element = document.createElement("li");
    all_assignments.appendChild(element);
    var link_assignment = document.createElement("a"); element.appendChild(link_assignment);
    link_assignment.appendChild(document.createTextNode(parsed_all[i].name)); link_assignment.setAttribute("href", "/api/assignments/" + parsed_all[i].id);
    link_assignment.setAttribute("id", parsed_all[i].id)
    link_assignment.addEventListener("click", display_assignment_info);
  }
});

// Send the request
route.send();

// Display one assignment's information to the DOM
function display_assignment_info(event){
  // Create new request; set id to current id; set the open request to the
  //  corresponding route path for the api assignment info.
  var assignment_request = new XMLHttpRequest();
  assignment_id = this.id
  var current_element = this;
  assignment_request.open("get", "/api/assignments/" + assignment_id);

  // Once request loads, run the function to display info correctly
  assignment_request.addEventListener("load", function(){
    // Create new ul element and append it under current li parent
    // Parse request's response
    var sub_list = document.createElement("ul");
    parent = current_element.parentElement;
    parent.appendChild(sub_list);
    var info = assignment_request.response;
    var assignment_info = JSON.parse(info);

    // Create an li element for assignment description; append to ul parent and
    //    fill in content
    var description_element = document.createElement("li");
    sub_list.appendChild(description_element);
    description_element.appendChild(document.createTextNode("Description: " + assignment_info.description))

    // Create an li element for where_stored; append it to ul parent and fill in
    //    content
    var where_stored_element = document.createElement("li");
    sub_list.appendChild(where_stored_element);
    where_stored_element.appendChild(document.createTextNode("Github Link: " + assignment_info.where_stored))

    // Create collaborators element and append to ul parent; Create a String and
    //  iterate over all collaborators, adding to the empty String. Fill in
    //  String to element.
    var collaborators_element = document.createElement("li");
    sub_list.appendChild(collaborators_element);
    var collabs = assignment_info.collaborators;
    var collab_string = "";
    for (var i = 0; i < collabs.length; i++) {
      collab_string += collabs[i].name + " ";
    }
    collaborators_element.appendChild(document.createTextNode("Collaborators: " + collab_string))

    // Create links li element and append to ul parent; Iterate over all Media
    //  items; create an anchor tag for each item and append it to the li item.
    //  Fill in href as where_stored and the name of the link as name.
    var links_element = document.createElement("li");
    sub_list.appendChild(links_element);
    var assign_links = assignment_info.links;
    links_element.appendChild(document.createTextNode("Media: "))
    for (var i = 0; i < assign_links.length; i++) {
      var media_link = document.createElement('a');
      links_element.appendChild(media_link);
      media_link.appendChild(document.createTextNode(assign_links[i].name + " \t"));
      media_link.setAttribute('href', assign_links[i].where_stored)
    }
  });

  // Prevent the default click action (going to assignment api page)
  event.preventDefault();
  // Send request
  assignment_request.send();
}
