var ready;
ready = function() {
  // Your JS here
  $("#registerButton").attr("disabled","disabled")
  $("#passwordField, #newPasswordField").keyup(function() {
    var estimation = zxcvbn($(this).val());

    switch (estimation.score){
      case 0:
        insertMessage("#"+$(this).attr("id"),"The password is very week","message")
        $("#registerButton").attr("disabled","disabled")
        break;
      case 1:
        insertMessage("#"+$(this).attr("id"),"The password is week","message")
        $("#registerButton").attr("disabled","disabled")
        break;
      case 2:
        insertMessage("#"+$(this).attr("id"),"The password is OK","message")
        $("#registerButton").attr("disabled","disabled")
        break;
      case 3:
        insertMessage("#"+$(this).attr("id"),"The password is strong","message")
        $("#registerButton").removeAttr("disabled")
        break;
      case 4:
        insertMessage("#"+$(this).attr("id"),"The password is very strong","message")
        $("#registerButton").removeAttr("disabled")
        break;
    }


  });
  $("#passwordConfirmationField,#newPasswordConfirmationField").keyup(function(){
    var value = $(this).val();
    var id = "" ;
    if ($(this).attr("id") == "passwordConfirmationField"){
      id = "#passwordField";
    }else {
      id = "#newPasswordField";
    }
    var otherValue = $(id).val();
    if (value != otherValue) {
      $("#registerButton").attr("disabled","disabled")
      insertMessage("#"+$(this).attr("id"),"The password didn't match","passwordNotMatch");
    }else{
      $("#registerButton").removeAttr("disabled")
      insertMessage("#"+$(this).attr("id"),"","passwordNotMatch");


    }
  });
  function insertMessage(x1,x2,x3){
    $("."+x3).remove();
    $(x1).after('<span class='+x3+'>' +x2 +'</span>');
  }

}

$(document).on('turbolinks:load', ready);
