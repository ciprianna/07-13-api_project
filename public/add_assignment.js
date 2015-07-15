var forms = document.forms;
var form_elements = forms[0].elements;
for (var i = 0; i < form_elements.length; i++) {
  if (form_elements[i].id == 'use_api') {
    form_elements[i].onclick = add_assignment;
  }
}

function add_assignment(event){
  var my_request = new XMLHttpRequest();

  var kvpairs = [];
  for ( var i = 0; i < (form_elements.length - 1); i++ ) {
    var e = form_elements[i];
    kvpairs.push(e.value);
  }
  var queryString = kvpairs.join("/");
  var route_path = "/api/create_assignment/";
  var this_link = route_path.concat(queryString);
  console.log(this_link);

  my_request.open("get", this_link);

  my_request.addEventListener("load", function(){
    // var form_div = document.getElementById('add_new_assignment_form');
    var success = document.getElementById('success');
    $(add_new_assignment_form).hide();
    success.innerText = my_request.response;
  })

  event.preventDefault();

  my_request.send();
}
