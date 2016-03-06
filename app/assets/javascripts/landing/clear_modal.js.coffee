# This script clears content in form fields and errors message in the modal window after it is closed.

$(document).on 'hidden.bs.modal', "#authentication_modal", ->
    $('#signin_errors_message').hide();
    $('#signin-email').val('');
    $('#signin-pass').val('');
    $('#signup_errors_message').hide();
    $('#signup-name').val('');
    $('#signup-email').val('');
    $('#signup-pass').val('');
    $('#signup-passconf').val('');
