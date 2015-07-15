var all_assignments = document.getElementById('list');
var route = new XMLHttpRequest();
route.open("get", "/api/assignments");

route.addEventListener("load", function(){
  var parsed_all = JSON.parse(route.responseText);

  for (i = 0; i < parsed_all.length; i++) {
    var element = document.createElement("li");
    all_assignments.appendChild(element);
    var link_assignment = document.createElement("a"); element.appendChild(link_assignment);
    link_assignment.appendChild(document.createTextNode(parsed_all[i].name)); link_assignment.setAttribute("href", "/api/assignments/" + parsed_all[i].id);
    link_assignment.setAttribute("id", parsed_all[i].id)
    link_assignment.addEventListener("click", display_assignment_info);
  }
});

route.send();

function display_assignment_info(event){
  var assignment_request = new XMLHttpRequest();
  assignment_id = this.id
  var current_element = this;
  assignment_request.open("get", "/api/assignments/" + assignment_id);


  assignment_request.addEventListener("load", function(){
    var sub_list = document.createElement("ul");
    parent = current_element.parentElement;
    parent.appendChild(sub_list);
    var info = assignment_request.response;
    var assignment_info = JSON.parse(info);


    var description_element = document.createElement("li");
    sub_list.appendChild(description_element);
    description_element.appendChild(document.createTextNode("Description: " + assignment_info.description))


    var where_stored_element = document.createElement("li");
    sub_list.appendChild(where_stored_element);
    where_stored_element.appendChild(document.createTextNode("Github Link: " + assignment_info.where_stored))


    var collaborators_element = document.createElement("li");
    sub_list.appendChild(collaborators_element);
    var collabs = assignment_info.collaborators;
    var collab_string = "";
    for (var i = 0; i < collabs.length; i++) {
      collab_string += collabs[i].name + " ";
    }
    collaborators_element.appendChild(document.createTextNode("Collaborators: " + collab_string))

    var links_element = document.createElement("li");
    sub_list.appendChild(links_element);
    var assign_links = assignment_info.links;
    links_element.appendChild(document.createTextNode("Media: "))
    for (var i = 0; i < assign_links.length; i++) {
      var media_link = document.createElement('a');
      links_element.appendChild(media_link);
      media_link.appendChild(document.createTextNode(assign_links[i].name));
      media_link.setAttribute('href', assign_links[i].where_stored)
    }
  });

  event.preventDefault();
  assignment_request.send();
}
