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

    footer {
      position: fixed;
      bottom: 0;
      width: 100%;
    }
    .container {
    	width: 50%;
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
            <%-- <li class="nav-item active">
              <a class="nav-link" href="${user.role=='admin' ? 'admin/admin-info.htm' : 'user/your-channel.htm'}"
                >Your profile<span class="sr-only">(current)</span></a
              >
            </li> --%>
          </ul>
          <div class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px"
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
          </div>
        </div>
      </nav>
    </header>
   
	<div class="container">
      <h2 class="h2-header text-center p-3	">Send us your feedback!</h2>
      <form
        action="${user.role == 'admin' ? 'admin' : 'user'}/send-feedback.htm"      >
        <div class="form-group">
          <label class="col-form-label">Title</label>
          <input
          	type="text"
            name="title"
            value="${title}"
            class="form-control"
          />
         <div class="error" style="display: ${title=='none'  ? 'none' : ''};">
          	${title}
          </div>
        </div>
        
        <div class="form-group">
           <label class="col-form-label">Please leave your feedback below</label>
          <textarea
          	rows="5"
            name="feedBack"
            class="form-control"
          >${feedBack}</textarea>
        	<div class="error" style="display: ${feedBack=='none'  ? 'none' : ''};">
          	${feedBack}
          </div>
   
        </div>
        <div class="mt-4">
          <button type="submit" class="btn btn-success  mr-2">Send</button>
          <button
            type="button"
            onclick="location.href='${user.role == 'admin' ? './admin/user-list.htm' : './user/home.htm'}'"
            class="btn btn-secondary"
            data-dismiss="modal"
            >Cancel</button
          >
        </div>
      </form>
      </div> 
     <footer class="main-footer">
      <div class="pull-right hidden-xs"><b>Version</b> 0.0.0.1</div>
      <strong
        >Copyright &copy; 2019
        <span style="color: #ff9999">${user.role=='admin' ? 'AdminEmotube' : 'Emotube'}</span></strong     
      >
    </footer>
  </body>
</html>
