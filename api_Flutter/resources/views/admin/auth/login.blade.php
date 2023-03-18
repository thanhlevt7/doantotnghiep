<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="{{ asset('backend/assets/css/main.css')
}}" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="{{asset('backend/assets/css/font-awesome-4.7.0/css/font-awesome.min.css')}}"/>
<link rel="stylesheet" type="text/css" href="{{asset('backend/assets/css/font-awesome-4.7.0/css/font-awesome.css')}}"/>
    <title>Đăng nhập</title>
  </head>
  <body>
     @if(session('error'))
          <div class="alert alert-danger" id="alert">
          <button type="button" class="close" data-dismiss="alert">x</button>
          {{session('error')}}</div>
      @endif
    <section class="material-half-bg">
      <div class="cover"></div>
    </section>


    <section class="login-content">
      <div class="logo">
        <h1>Vali</h1>
      </div>
      <div class="login-box">
      <form class="login-form" action="{{ route('admin.login.post') }}"method="POST" role="form">
      {{csrf_field() }}
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>Sign in</h3>
          <div class="form-group">
            <label class="control-label">Email-address</label>
            <input class="form-control" type="email" id="email" name="email" placeholder="Email address" autocomplete="off" autofocus value="{{ old('email') }}">
          </div>
          <div class="form-group">
            <label class="control-label">Password</label>
            <input class="form-control" id="password" name="password" type="password" placeholder="Password">
          </div>
          <div class="form-group">
            <div class="utility">
              <div class="animated-checkbox">
                <label>
                  <input type="checkbox"><span class="label-text">Stay Signed in</span>
                </label>
              </div>

            </div>
          </div>

          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block"><i class="fa fa-sign-in fa-lg fa-fw"></i>SIGN IN</button>
          </div>



        </form>

      </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Essential javascripts for application to work-->
    <script src="{{asset('js/jquery-3.2.1.min.js')}}"></script>
    <script src="{{asset('js/popper.min.js')}}"></script>
    <script src="{{asset('js/bootstrap.min.js')}}"></script>
    <script src="{{asset('js/main.js')}}"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="{{asset('js/plugins/pace.min.js')}}"></script>
    <script type="text/javascript">
      // Login Page Flipbox control
      $('.login-content [data-toggle="flip"]').click(function() {
      	$('.login-box').toggleClass('flipped');
      	return false;
      });
    </script>
    <script type="text/javascript">
      $("document").ready(function()
      {
        setTimeout(function()
        {
          $("div.alert").remove();
        }, 3000);
      });
    </script>
  </body>
</html>
