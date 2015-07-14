
var forms = document.forms;
var single_form = forms[0];
single_form[3].onclick = add_assignment;

function add_assignment(event){
  var this_link = document.getElementById('/api/create_assignment');

  var my_request = new XMLHttpRequest();

  my_request.open("get", this_link);

  my_request.addEventListener("load", function(){
    var form_div = document.getElementById('add_new_assignment_form');
    form_div.display = "none";
    var success = document.getElementById("success");
    var assignment_name = document.getElementById('assignment_name').value;
    success.innerText = "You've successfully added " + assignment_name + " to the database."
  })

  event.preventDefault();

  my_request.send();
}
