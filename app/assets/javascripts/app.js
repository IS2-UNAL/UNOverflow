var ready;
ready = function() {
  $('a[href*="#"]:not([href="#carouselHome"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
  $('#search').keyup(function(){
    $('#tags_search').submit();
  });
  $("#alert-app").fadeTo(2000,500).slideUp(500, function(){
      $("#alert-app").alert('close');
  });
  $("#tab-first").click(function(){
    $("#tab-second").removeClass("active")
    $("#tab-third").removeClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").addClass("active")
  });
  $("#tab-second").click(function(){
    $("#tab-second").addClass("active")
    $("#tab-third").removeClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").removeClass("active")
  });
  $("#tab-third").click(function(){
    $("#tab-second").removeClass("active")
    $("#tab-third").addClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").removeClass("active")
  });
  $("#tab-fourth").click(function(){
    $("#tab-second").removeClass("active")
    $("#tab-third").removeClass("active")
    $("#tab-fourth").addClass("active")
    $("#tab-first").removeClass("active")
  });
  $("#titleOrder").click(function(){
      var value = $("#carretOrder").text();
      if(value == String.fromCharCode(9660)){
        $("#carretOrder").text(String.fromCharCode(9650));
        $("#order").val("DESC");
      }else {
        $("#carretOrder").text(String.fromCharCode(9660));
        $("#order").val("ASC");
      }
      $('#tags_search').submit();

  });
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
