window.fbAsyncInit = function() {
    FB.init({
      appId      : '177537562330878', // App ID
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
            success: function(){              
              window.location = "/"
            },
            error: function(){
              alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')
            }
          });

        });
      } else {
          // cancelled
      }
    }, {scope: 'email'});
  }

  application.logout = function(){
    $.ajax({
      type: "POST",
      url: "/logout",      
      success: function(){window.location = "/"},
      error: function(){
        alert('Terjadi Kesalahan ketika login.. silahkan coba lagi')
      }
    });
  }
}

$(document).ready(function(){
  window.app = new application();
})
