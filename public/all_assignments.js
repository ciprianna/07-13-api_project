

window.onload = function() {
  var all_assignments = document.getElementById('list');
  var route = new XMLHttpRequest();
  route.open("get", "/api/assignments");
  route.send();

  // var parsed_var = route.response;
  var parsed_all = JSON.parse(route.response);

  for (i = 0; i < parsed_all.length; i++) {
    var element = document.createElement("li");
    all_assignments.appendChild(element);
    element.appendChild(document.createTextNode(parsed_all[i].name));
  }
}
