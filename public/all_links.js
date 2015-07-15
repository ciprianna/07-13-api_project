// Get list element and set the request
var all_links = document.getElementById('list');
var route = new XMLHttpRequest();
route.open("get", "/api/links");

// When request loads, run this function to display link info
route.addEventListener("load", function(){
  // Parse the request's response
  var parsed_links = JSON.parse(route.response);

  // Iterate through results and create a new list element for each one;
  //   Append to ul element; Create a link element; Append to new li element;
  //   Set the link path to the api route for the media's where_stored
  for (var i = 0; i < parsed_links.length; i++) {
    var element = document.createElement('li');
    all_links.appendChild(element);
    var link_path = document.createElement("a");
    element.appendChild(link_path);
    link_path.setAttribute("href", parsed_links[i].where_stored);
    link_path.appendChild(document.createTextNode(parsed_links[i].name));
  }
})

// Send the request
route.send();
