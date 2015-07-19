// Select the list element
var list_element = document.getElementById('list');

// Create new request
var my_request = new XMLHttpRequest();

// The request route
my_request.open("get", "/api/collaborators")

// Upon request load
my_request.addEventListener("load", function(){
  // Get the response text back and parse it
  response = my_request.response;
  collaborator_info = JSON.parse(response);

  // Loop through JSON objects and create elements for them
  for (var i = 0; i < collaborator_info.length; i++) {
    var element = document.createElement("li");
    list_element.appendChild(element);
    var link = document.createElement("a");
    element.appendChild(link);
    link.appendChild(document.createTextNode(collaborator_info[i].name));
    link.setAttribute("href", "collaborators/" + collaborator_info[i].id);
    link.setAttribute("id", collaborator_info[i].id);
    link.addEventListener("click", display_collaborator_info);
  }

});

// Send the request
my_request.send();


function display_collaborator_info(event){
  var this_collaborator = this.id
  var this_element = this

  var collaborator_request = new XMLHttpRequest();
  collaborator_request.open("get", "/api/collaborators/" + this_collaborator)

  collaborator_request.addEventListener("load", function(){
    var sub_list = document.createElement("ul");
    var parent_list_element = this_element.parentElement;
    parent_list_element.appendChild(sub_list);
    response = collaborator_request.response
    assignments = JSON.parse(response);
    for (var i = 0; i < assignments["assignments"].length; i++) {
      var element = document.createElement("li");
      sub_list.appendChild(element);
      element.appendChild(document.createTextNode(assignments["assignments"][i].name));
    }
  })

  event.preventDefault();

  collaborator_request.send();
}
