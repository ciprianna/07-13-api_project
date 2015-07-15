var all_assignments = document.getElementById('list');
var route = new XMLHttpRequest();
route.open("get", "/api/assignments");

route.addEventListener("load", function(){
  var parsed_all = JSON.parse(route.responseText);

  for (i = 0; i < parsed_all.length; i++) {
    var element = document.createElement("li");
    all_assignments.appendChild(element);
    element.appendChild(document.createTextNode(parsed_all[i].name));
  }
});

route.send();
