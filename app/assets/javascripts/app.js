Dropzone.autoDiscover = false;
$(document).ready(function(){
  $('[data-toggle="offcanvas"]').click(function () {
    $('.row-offcanvas').toggleClass('active')
  });
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
  tinymce.remove();
  tinymce.init({
    selector:'#descriptionField',
    toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image |  preview media fullpage | forecolor backcolor emoticons codesample',
    plugins : 'advlist template searchreplace spellchecker autolink link image lists charmap hr table textcolor codesample preview pagebreak wordcount emoticons insertdatetime',
    statusbar: false,
    menubar: false

  });
  $("#up").click(function(){
    $("#is_possitive").val("1");
    $("#addLike").submit();
  });
  $("#down").click(function(){
    $("#is_possitive").val("2");
    $("#addLike").submit();
  });

  $('#tagField').keyup(function(){
    if ($('#tagField').val() == "") {
      $('.tagSuggest').remove();
    }else {
      $.ajax({
        url: "/posts/suggest" ,
        type: "GET",
        data: {titleTag: $('#tagField').val()},
        success: function(result){
        }
      });
    }
  });
  $('#userField').keyup(function(){
    if($('#userField').val() == ""){
      $('.userSuggest').remove();
    }else{
      $.ajax({
        url: "/posts/userSuggest",
        type: "GET",
        data: {username: $('#userField').val()},
        success: function(resutl){}
      });
    }
  });
  $('#tagFieldSearch').keyup(function(){
    if($('#tagFieldSearch').val() == ""){
      $('.tagFieldSearch').remove();
    }else{
      $.ajax({
        url: "/posts/suggest",
        type: "GET",
        data: {titleTag: $('#tagFieldSearch').val(),filter: ""},
        success: function(resutl){}
      });
    }
  });
  $(document).on('click',"#tagButton",function(){
    $('#tagFieldSearch').val("");
    $('.tagFieldSearch').remove();
    $('#searchPost').val("");
    var i = "0"
    var j = "0"
    if($('#solved').is(':checked')){
      i = "1"
    }
    if($('#noSolved').is(':checked')){
      j = "1"
    }
    $.ajax({
      url: "/posts/searchTag",
      type: "GET",
      data: {id: $(this).attr('value'),type:$("#type").val(),solved:i,noSolved:j},
      success: function(result){}
    });
  });
  $(document).on('click',"#userButton",function(){
    $('#userField').val("");
    $('.userSuggest').remove();
    $('#searchPost').val("");
    var i = "0"
    var j = "0"
    if($('#solved').is(':checked')){
      i = "1"
    }
    if($('#noSolved').is(':checked')){
      j = "1"
    }
    $.ajax({
      url: "/posts/searchUser",
      type: "GET",
      data: {username: $(this).attr('value'),type: $("#type").val(),solved:i,noSolved:j},
      success: function(result){}
    });

  });

  $('#search').keyup(function(){
    $('#tags_search').submit();
  });
  $('#searchPost').keyup(function(){
    $('#post_search').submit();
  });
  $("#alert-app").fadeTo(4000,0.7).slideUp(1000, function(){
      $("#alert-app").alert('close');
  });
  $("#tab-first").click(function(){
    $('#searchPost').val("");
    $('#solved').prop('checked',true);
    $('#noSolved').prop('checked',true);
    $('#type').val("all");
    $("#tab-second").removeClass("active")
    $("#tab-third").removeClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").addClass("active")
  });
  $("#tab-second").click(function(){
    $('#searchPost').val("");
    $('#solved').prop('checked',true);
    $('#noSolved').prop('checked',true);
    $('#type').val("lastDay");
    $("#tab-second").addClass("active")
    $("#tab-third").removeClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").removeClass("active")
  });
  $("#tab-third").click(function(){
    $('#searchPost').val("");
    $('#solved').prop('checked',true);
    $('#noSolved').prop('checked',true);
    $('#type').val("lastWeek");
    $("#tab-second").removeClass("active")
    $("#tab-third").addClass("active")
    $("#tab-fourth").removeClass("active")
    $("#tab-first").removeClass("active")
  });
  $("#tab-fourth").click(function(){
    $('#searchPost').val("");
    $('#solved').prop('checked',true);
    $('#noSolved').prop('checked',true);
    $('#type').val("lastMonth");
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
  $('#solved,#noSolved').change(function(){
    var i = "0"
    var j = "0"
    if($('#solved').is(':checked')){
      i = "1"
    }
    if($('#noSolved').is(':checked')){
      j = "1"
    }
    $('#solvedValue').val(i);
    $('#noSolvedValue').val(j);
    $('#post_search').submit();

  });

  $(document).on("click", "#tagButtonCreate", function(event){
    //alert( $('#tagButton').attr("value"));
    var value = $('#tagsValues').val();
    $("h4").remove();
    $("span").remove();
    if (value == "" ){
      //alert("hola");
      $('#tagField').removeAttr('required');

      var item = $("#tagsValues").val($(this).attr("value")+",")
      $("#tagField").after("<h4><span class='label label-default' id='tagLabels'>"+ $(this).attr("value") +"</span></h4>");
    }else{
      //alert("hola1");
      var otherValue = $(this).attr("value") + ",";
      //console.log(otherValue);
      value = value.concat(otherValue);
      var newValues = value.substring(0, value.length -1 );
      var array = newValues.split(",");
      var mySet = new Set();
      for(var i = 0; i < array.length; i++){
        //console.log(array[i]);
        mySet.add(array[i]);
      }
      //console.log(mySet);
      newValues = "";

      mySet.forEach(function(item){
        $("#tagField").after("<h4><span class='label label-default' id='tagLabels'>"+ item  +"</span></h4>");
        newValues = newValues.concat(item + ",");
      });


      $("#tagsValues").val(newValues);
      //console.log(newValues);

    }
    $('.tagSuggest').remove();
    $('#tagField').val("");
  });
  $(document).on("click","#tagLabels", function(event){
    var value = $(this).text();
    $(this).remove();
    var tagValues = $("#tagsValues").val();
    var array =  tagValues.split(",");
    var otherArray =  [];
    var newValues = "";
    for(var i=0; i<array.length; i++){
      if(array[i] != value && array[i] != ""){
        otherArray.push(array[i]);
        newValues = newValues.concat(array[i]);
      }
    }
    if (otherArray.length > 0) {
      $("#tagsValues").val(newValues);
    }else{
      $('#tagField').prop('required',true);
      $("#tagsValues").val("");
    }
    //console.log(value);
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
  $(document).on("click","#logInButton", function(event){
    $( ".logIn" ).submit();
  });
  $("#passwordConfirmationField,#newPasswordConfirmationField").keyup(function(){
    var value = $(this).val();
    var id = "" ;
    if ($(this).attr("id") == "passwordConfirmationField"){
      id = "#passwordField";
    }else {
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

  var mediaDropzone = new Dropzone("#media-dropzone");
  Dropzone.options.mediaDropzone = {
    success: function (response) {
                eval(response.xhr.response);
            }
  };
  mediaDropzone.options.acceptedFiles = ".jpeg,.jpg,.png,.gif";
  mediaDropzone.options.maxFiles = 1;
  mediaDropzone.options.parallelUploads = 1;
  mediaDropzone.on("maxfilesexceeded", function(file) {
        mediaDropzone.removeAllFiles();
        mediaDropzone.addFile(file);
  });
  mediaDropzone.on("complete", function(file) {
    var response = JSON.parse(file.xhr.response);
    var _this = this;
    if (_this.getUploadingFiles().length === 0 && _this.getQueuedFiles().length === 0) {
      setTimeout(function(){
        var rejectedFiles = _this.getRejectedFiles();
        if (rejectedFiles.length != 0) {
          alert("This file is not accepted")
        }
        $("#modalDropzone").modal('hide')
        mediaDropzone.removeFile(file)
        window.location.href = (response.name+response.id)
      },2000);
    }

  });

});
