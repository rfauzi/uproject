$(document).ready(function(){
  window.app = new application();
  app.sendMessage();
  app.initUserProfile();
  app.displayPopup();   
})


window.fbAsyncInit = function() {
    //  devel: '161569670599063', prod: '177537562330878'
    FB.init({
      appId      : '161569670599063', // App ID
      channelUrl : 'http://ummiproject.herokuapp.com/channel', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });

    // Additional init code here
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";     
     ref.parentNode.insertBefore(js, ref);
   }(document));


function application() {
  var application = this;

  application.login = function(){
    $.ajax({
      type: "POST",
      url: "/facebook_auth",
      beforeSend: function(){$('#loader').show()},
      complete: function(){$('#loader').hide()},
      success: function(data){window.location.reload()},
      error: function(){alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')}
    });

  }
  application.login = function(){
    FB.login(function(response) {
      if (response.authResponse) {
        var _access_token = response.authResponse.accessToken;
        var _uid = response.authResponse.userID;
        FB.api('/me', function(response) {
          var _username = response.username;
          var _bio = response.bio;
          var _email = response.email

          $.ajax({
            type: "POST",
            url: "/facebook_auth",
            data: {username: _username, uid: _uid, access_token: _access_token, bio: _bio, email: _email},
            beforeSend: function(){$('#loader').show()},
            complete: function(){$('#loader').hide()},
            success: function(data){window.location.reload()},
            error: function(){alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')}
          });

        });
      } else {
          // cancelled
      }
    }, {scope: 'email, publish_actions, read_mailbox'});
  }

  application.logout = function(){
    $.ajax({
      type: "POST",
      url: "/logout",
      beforeSend: function(){$('#loader').show()},
      complete: function(){$('#loader').hide()},
      success: function(data){ window.location.reload()},
      error: function(){alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')}
    });
  }

  application.close = function(el){
    $(el).remove()
  }

  application.animateFooter = function(){
    clone  = $('#footer').clone().addClass('clone');
    $('#footer').slideUp();
    setTimeout($('#main').after(clone), 1000);
    $('.clone').typewriter();
    setTimeout(function(){
      $('.clone').slideUp().remove();
      $('#footer').slideDown();
    }, 15000) 
  }

  application.initUserProfile = function(){
    $('.wrapper .checklist.true').hover((function(){
      $(this).siblings(".floater-info").slideDown('fast');
    }), function(){
      $(this).siblings(".floater-info").slideUp('fast')
    })
  }

  application.sendMessage = function(){
    $('#message-form .send-message').live('click', function(){
      _message = $('#message-form .message').val();
      $.ajax({
        type: "POST",
        url: "/message",
        data: {message: _message},
        beforeSend: function(){$('#loader').show()},
        complete: function(){$('#loader').hide()},
        success: function(data){
          $('#message-box .wrapper').append(data);
          $new_element = $('#message-box .wrapper .message').last()
          $new_element.hide().slideDown()
          $('#message-form .message').val('');
          $('#message-box').animate({ scrollTop: $('#message-box')[0].scrollHeight}, 800);
        },
        error: function(){alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')}
      });
    })
  }

  application.displayPopup = function(){
    $('[rel="data-popup"]').live('click', function(){
      popup_el    = $(this).attr('data-popup');
      overlay_id  = "popup-overlay"
      overlay_el  = '<div id='+ overlay_id +'></div>'
      $('body').append(overlay_el);
      $(popup_el).show();
      $("#"+ overlay_id).live('click', function(){$(popup_el).hide(); $(this).remove()})
      $(popup_el).live('click', function(){event.stopPropagation();})
    })
  }
}
