// MY CALENDAR datepicker

  function showCalendar(element) {
    var offset = element.offset();
    $("#calendarContainer").hide();
    $("#calendarContainer")
      .fadeToggle(300)
      .css({
        left: offset.left - 140,
        top: offset.top - 216
      });
    };

  $(document).on('click', '.due-to', function() {
    showCalendar($(this));
  });

  $('html').click(function(e) {
   if(!$(event.target).closest('#calendarContainer').length &&
     !$(event.target).is('#calendarContainer')) {
      if($('#calendarContainer').is(":visible")) {
        $('#calendarContainer').hide()
      }
    }
  });
