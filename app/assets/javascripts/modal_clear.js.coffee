$(document).on 'hidden.bs.modal', "#authentication_modal", ->
    $('#signup_errors_message').hide();
    $('#signup-name').val('');
    $('#signup-email').val('');
    $('#signup-pass').val('');
    $('#signup-passconf').val('');
