$(document).on('turbolinks:load', function () {
  $( "#delete_account").click(function () { return false; });

  $("#enable_button").click(function () {
    if (this.checked && confirm('Your profile will be permanently deleted')) {
      $("#delete_account").removeClass("disabled");
      $("#delete_account").off('click');
    } else {
      this.checked = false;
      $("#delete_account").addClass("disabled");
      $( "#delete_account").click(function () { return false; });
    }
  });
});


$(document).ajaxStart(function(){
  $("#overlay").fadeIn(300);
});

$(document).ajaxStop(function(){
  setTimeout(function(){
    $("#overlay").fadeOut(300);
  },500);
});

function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  ev.dataTransfer.setData("avatar_id", ev.target.getAttribute('value'));
}

function drop(ev) {
  ev.preventDefault();
  var data = ev.dataTransfer.getData("avatar_id");
  const input = document.getElementById('user_avatar');
  input.value = data;
  $("#avatar_form").submit();
}

if (!window.hasOwnProperty( 'avatar' )) {
  const avatar = document.getElementById('avatar');
};
