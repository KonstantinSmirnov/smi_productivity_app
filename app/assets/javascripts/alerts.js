$(function() {
  setTimeout(function(){
    $(".alert-disappear").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
  }, 3000);
});
