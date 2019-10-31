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
    <!-- <script src="./resources/js/register.js"></script> -->
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

      form {
        padding: 0px 17px;
      }
      input {
      	outline: none;
      	border-radius: 7px;
      	margin: 5px;
      	padding: 5px;
   	 	padding-left: 14px
      }
      .sign-up {
      	padding: 22px;
    	padding-top: 7px;
    	padding-bottom: 7px;
      }
    </style>
  </head>

  <body>
    <h1 class="m-3">Welcome to Emotube</h1>
    <!-- Sign up form -->
    <div class="container right-panel-active" id="container">
      <div class="form-container sign-up-container">
        <form:form action="sign-up.htm" modelAttribute="user" enctype="multipart/form-data">
          <h3 style="font-weight: bold">Create Account</h3>
          
          <form:input path="user_name" placeholder="Username" />
          <form:errors path="user_name" class="error" />
          
          <form:input path="first_name" placeholder="First name" />
          <form:errors path="first_name" class="error" />
              
          <form:input path="last_name" placeholder="Last name" />
          <form:errors path="last_name" class="error" />

          <form:input type="email" path="email" placeholder="Email" />
          <form:errors path="email" class="error" />
          
          <input type="file" name="profile" placeholder="Profile image" />
          <form:errors path="profile_image" class="error" />
          
          <form:password path="password" placeholder="Password" />
          <form:errors path="password" class="error" />

          <button class="sign-up">Sign Up</button>
        </form:form>
      </div>
      <div class="overlay-container">
        <div class="overlay">
          <div class="overlay-panel overlay-left">
            <h2>Welcome Back!</h2>
            <p>
              To keep connected with us please login with your personal info
            </p>
            <button
              onclick="location.href='sign-in.htm'"
              class="ghost"
              id="signIn"
            >
              Sign In
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
