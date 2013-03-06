window.fbAsyncInit = function() {
    FB.init({
      appId      : '177537562330878', // App ID
      channelUrl : 'http://0.0.0.0:4567/channel', // Channel File
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


function login() {
  FB.login(function(response) {
      if (response.authResponse) {
          // connected
      } else {
          // cancelled
      }
  });
}

function getFbAuth(){
  var resp;
  FB.api('/me', function(response) {
    resp = response
  });
  return resp
}
