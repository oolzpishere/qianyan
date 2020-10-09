
$(document).on("ready page:load turbolinks:load", function() {

  if ( 0 < $('#stream-window-wrap').length ) {
    // height detect
    function reSetHeight(){
      var viewportHeight = window.innerHeight;
      var windowHeight = viewportHeight;
      $('#stream-window').attr({height: windowHeight});
    }
    // init #stream-window height
    reSetHeight();
    $(window).on('resize',reSetHeight);

    // heart beat ajax
    // 60 * 1000 = 1min
    let intervalTime = 0.3 * 60 * 1000
    var subject = $('#stream-window-wrap').data('subject')
    var checkLoginIntervalId = setInterval(ajaxCheckLogin, intervalTime);

    function ajaxCheckLogin() {
      $.ajax({
        type: "POST",
        url: '/streams/login_status',
        data: {subject: subject},
        success: function(data){ checkLoginCallBack(data) },
        dataType: 'json'
      });
    }

    function checkLoginCallBack(data) {
      if (data["login_status"] == true) {
        // havn't been login at other device, session token not change, do nothing.
      } else {
        // login status equal fail redirect to login page.
        clearInterval(checkLoginIntervalId);
        // similar behavior as clicking on a link
        let login_page = window.location.origin + '/streams/' + subject + '/new'
        window.location.href = login_page;
      }
    }

  }
});
