//This script needs to make bigger comments field when clicked and
// make it smaller like before after clicking outside the form (outside the id=comment-form)
//it could be done with on.focus and on.blur functions, but then I had such problems:
//if form should be larger on focus, it reverted to small when go to another
//tab in browser and get back to big when go back to the tab with the application
//if form should get back in small size when field is blur, it did it when I click in any
//place outside the field even the Comment button.


$(function() {
  $(document).on('click', '.comment-form .expand', function() {
    $(".comment-form .expand").animate({ height: "6em" }, 200);
    $(".comment-form .controls").delay( 15 ).slideDown( 400 );
  });

  $(document).click(function (e) {
    var container = $("#comment-form");
    if (!container.is(e.target) // if the target of the click isn't the container...
        && container.has(e.target).length === 0) // ... nor a descendant of the container
    {
      $(".comment-form .expand").animate({ height: "2.35em"}, 200);
      $(".comment-form .controls").hide();
    }
  });

});



