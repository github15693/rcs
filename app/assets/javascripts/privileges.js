
//function alert message
function delayedAlert(msg, time) {
    $('#notifications').html("<div class='alert alert-success alert-dismissible' role='alert'><button type='button' class='close' data-dismiss='alert'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>" + msg + "</div>");
    setTimeout(function () {
        $('#notifications').html('');
    }, time);
};

