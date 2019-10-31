<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <title>Insert title here</title>
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
  </style>

  <body>
    <header>
      <nav
        class="navbar navbar-expand-lg navbar-dark bg-dark pt-1 pb-1"
        style="background-color:#374850!important;"
      >
        <a class="navbar-brand" style="  color: #ff9999 !important;" href="#"
          ><b>EMOTUBE</b></a
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
            <li class="nav-item active">
              <a class="nav-link" href="#"
                >Home<span class="sr-only">(current)</span></a
              >
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a href="#" class="nav-link">
                  <img
                    style="width: 38px; padding-right: 10px"
                    src="./files/logo.jpg"
                    class="user-image"
                    alt="profile image"
                  /><span class="hidden-xs">Nguyen Ngoc Thanh</span>
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

	<div style="margin-bottom: 500px">
	<div class="container">
      <%-- <h2 class="h2-header">Change password <i>(${user.user_name})</i></h2> --%>
      <form
        action="${user.role == 'admin' ? 'admin' : 'user'}/change-password/${user.id}.htm"      >
        <div class="form-group">
          <label class="col-form-label">Current Password</label>
          <input
            name="current-password"
            class="form-control"
          />
         <%--  <p style="display: none">${current-password-error}</p> --%>

        </div>
        <div class="form-group">
           <label class="col-form-label">New Password</label>
          <input
            type="password"
            name="new-password"
            class="form-control"
          />
          <%-- <p style="display: none">${new-password-error}</p> --%>
        </div>
         <div class="form-group">
             <label class="col-form-label">Confirm New Password</label>
          <input
            name="confirm-new-password"
          	type="password"
            class="form-control"
          />
	      <%--  <p style="display: none">${confirm-password-error}</p> --%>
          </div>
        <div class="mt-4">
          <button type="submit" class="btn btn-success">Save</button>
          <button
            type="button"
          <%--   onclick="location.href='${user.role == 'admin' ? './admin/admin-info.htm' : './user/your-channel.htm'}'" --%>
            class="btn btn-secondary"
            data-dismiss="modal"
            >Cancel</button
          >
        </div>
      </form>
      </div> 
	</div>

    <footer class="main-footer">
      <div class="pull-right hidden-xs"><b>Version</b> 0.0.0.1</div>
      <strong
        >Copyright &copy; 2019
        <span style="color: #ff9999">Emotube</span></strong
      >
    </footer>
  </body>
</html>
