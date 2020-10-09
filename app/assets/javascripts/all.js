
$(document).on("ready page:load turbolinks:load", function() {
  // hide alert after 15s.
  if ($('.alert')) {
    setTimeout(function() {
      $('.alert').alert('close')
    }, 15000)
  }


});
