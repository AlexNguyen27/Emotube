<%@ page pageEncoding="UTF-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
   <title>Emotube</title>
    <script type="text/javascript" src="./bootstrap/js/jquery-min.js"></script>
    <link
      href="./bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
      type="text/css"
    />

    <script
      type="text/javascript"
      src="./bootstrap/js/bootstrap.min.js"
    ></script>
    <link
      href="./resources/css/register.css"
      type="text/css"
      rel="stylesheet"
    />
    <style>
      .error {
        color: red;
        width: 100%;
        text-align: left;
        font-size: 14px;
      }

      .error-head {
        text-align: center;
      }
      
       input {
      	outline: none;
      	border-radius: 7px;
      }
    </style>
  </head>

  <body>
    <h1 class="m-3">Welcome to Emotube</h1>
    <!-- Sign up form -->
    <div class="container" id="container">
      <!-- Sign in form  -->
      <div class="form-container sign-in-container">
        <form:form action="sign-in.htm" modelAttribute="user">
          <h2>Sign in</h2>
          <div class="error error-head">${wrongInput}</div>
          <form:input path="user_name" placeholder="Username" />
          <form:errors path="user_name" class="error" />
          <form:password path="password" placeholder="Password" />
          <form:errors path="password" class="error" />
          <a href="#">Forgot your password?</a>
          <button>Sign In</button>
        </form:form>
      </div>
      <div class="overlay-container">
        <div class="overlay">
          <div class="overlay-panel overlay-left">
            <h2>Welcome Back!</h2>
            <p>
              To keep connected with us please login with your personal info
            </p>
            <button class="ghost" id="signIn">Sign In</button>
          </div>
          <div class="overlay-panel overlay-right">
            <h2>Hello, Friend!</h2>
            <p>Enter your personal details and start journey with us</p>
            <button
              onclick="location.href='sign-up.htm'"
              class="ghost"
              id="signUp"
            >
              Sign Up
            </button>
          </div>
        </div>
      </div>
    </div>

    <footer>
      <p>Copyright @2019 - Emotube</p>
    </footer>
  </body>
</html>
