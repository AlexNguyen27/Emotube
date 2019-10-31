<%@ page pageEncoding="utf-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <base href="${pageContext.servletContext.contextPath}/" />
    <title>Emotube</title>
    <link
      href="./bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <script type="text/javascript" src="./bootstrap/js/jquery-min.js"></script>

    <script
      type="text/javascript"
      src="./bootstrap/js/bootstrap.min.js"
    ></script>
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
    />
  </head>
  <style>
    .main-footer {
      background: #fff;
      padding: 15px;
      color: #444;
      border-top: 1px solid #d2d6de;
      transition: transform 0.3s ease-in-out, margin 0.3s ease-in-out;

      z-index: 820;
    }

    .pull-right {
      float: right !important;
    }

   /*  footer {
      position: fixed;
      bottom: 0;
      width: 100%;
    } */
    .container {
    	width: 80%;
    }
    .col-form-label {
    	font-size: 17px;
    	font-weight: bold;
    }
    div .error {
    	color: red;
    }
  </style>

  <body>
    <header>
      <nav
        class="navbar navbar-expand-lg navbar-dark bg-dark pt-1 pb-1"
        style="background-color:#374850!important;"
      >
        <a class="navbar-brand" style="  color: #ff9999 !important;" href="user/home.htm"
          ><b>${user.role == 'admin' ? 'AdminEMOTUBE' : 'EMOTUBE'}</b></a
        >
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a href="#" class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px; border-radius: 50%"
                    src="./files/${user.profile_image}"
                    class="user-image"
                    alt="profile image"
                  /><span class="hidden-xs">${user.first_name} ${user.last_name}</span>
                </a>
              </li>
              <li class="nav-item active">
                <a href="log-out.htm" class="nav-link">
                  <i class="fas fa-sign-out-alt"></i>
                  <span class="hidden-xs">Log out </span>
                </a>
              </li>
            </ul>
          </form>
        </div>
      </nav>
    </header>
   
	<div class="container mb-4">
      <h2 class="h2-header text-center p-3 font-italic">How to use Emotube</h2>
     	<div>
			<h3 class="mb-4">1. Home Page</h3>
			<img style="width: 100%" src="./files/help1.png" class="mb-3"/>

			<h3>2. Your Channel</h3>
			<h4 class="ml-3 font-italic">2.1 Add, update, delete your video</h4>
			<img style="width: 100%" src="./files/help4.png" class="mb-3"/>
			
			<h4 class="ml-3 font-italic">2.2 Update your profile</h4>
			<img style="width: 100%" src="./files/help6.png" class="mb-3"/>
			
			<h4 class="ml-3 font-italic">2.3 Change your password</h4>
			<img style="width: 100%" src="./files/help5.png" class="mb-3"/>

			<h3 class="mb-2">3. Categories</h3>
			<h4 class="ml-3 mb-3 font-italic">Watch videos of each category that your selected</h4>
			<img style="width: 100%" src="./files/help7.png" class="mb-3"/>
			
			<h3 class="mb-2">3. View video</h3>
			<h4 class="ml-3 font-italic">You can like, dislike, comment, subscribe emotuber and video you like</h4>
			<img style="width: 100%" src="./files/help9.png" class="mb-3"/>
			<img style="width: 100%" src="./files/help10.png" class="mb-3"/>
 		
     	</div>
      </div> 
      
      <jsp:include page="./include/footer.jsp">
     <jsp:param value="${user.role}" name="userRole"/>
     </jsp:include>
  </body>
</html>
