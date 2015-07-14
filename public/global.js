// var forms = document.forms;
// var form_elements = forms[0].elements;
// for (var i = 0; i < form_elements.length; i++) {
//   if (form_elements[i].id == 'use_api') {
//     form_elements[i].onclick = add_assignment;
//   }
// }
//
// function add_assignment(event){
//   var my_request = new XMLHttpRequest();
//
//   var kvpairs = [];
//   for ( var i = 0; i < form_elements.length; i++ ) {
//     var e = form_elements[i];
//     kvpairs.push(e.name + "=" + e.value);
//   }
//   var queryString = kvpairs.join("/");
//   var route_path = "/api/create_assignment/";
//   var this_link = route_path.concat(queryString);
//   console.log(this_link);
//
//   var form_action = document.getElementById('form_action');
//   form_action.setAttribute('action') = this_link
//
//
//   my_request.open("get", this_link);
//
//   // my_request.addEventListener("load", function(){
//   //   var form_div = document.getElementById('add_new_assignment_form');
//   //   form_div.display = "none";
//   //   var success = document.getElementById("success");
//   //   var assignment_name = document.getElementById('assignment_name').value;
//   //   success.innerText = "You've successfully added " + assignment_name + " to the database."
//   // })
//   //
//   // event.preventDefault();
//
//   my_request.send();
// }
