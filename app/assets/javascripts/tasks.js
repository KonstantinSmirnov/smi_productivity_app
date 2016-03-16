$(function() {
  $('.task-body').click(function() {
    if ($(this).parent().parent().hasClass('active')) {
      $('.tasks').removeClass('doubled');
      $('#tasks-left').removeClass('tasks-left-part');
      $('#tasks-right').removeClass('tasks-right-part');
      $(this).parent().parent().removeClass('active');
    } else {
      $('.tasks').addClass('doubled');
      $('#tasks-left').addClass('tasks-left-part');
      $('#tasks-right').addClass('tasks-right-part');
      $(this).parent().parent().addClass('active');
    }
  });
});
