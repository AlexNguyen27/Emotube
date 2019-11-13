<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
	
    <script
      type="text/javascript"
      src="./bootstrap/js/bootstrap.min.js"
    ></script>

    <style>
      .form-group {
        margin-bottom: 0px;
      }

      .container table {
        width: 70%;
        margin: 0 auto;
        padding: 0px;
      }

      .h2-header {
        margin-top: 0.5rem;
        text-align: center;
      }

      .form-group label {
        font-weight: bold;
        font-size: 17px;
      }

      .radioButton {
        padding-top: 10px;
      }

      .video-table {
        width: 90%;
        margin: 0 auto;
      }
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
	    
    </style>
  </head>

  <body>
  <header>
      <nav
        class="navbar navbar-expand-lg navbar-dark bg-dark pt-1 pb-1"
        style="background-color:#374850!important;"
      >
        <a class="navbar-brand" style="  color: #ff9999 !important;" href="admin/user-list.htm"
          ><b>AdminEMOTUBE</b></a
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
              <a class="nav-link" href="admin/category-list.htm"
                >Categories<span class="sr-only">(current)</span></a
              >
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
              <%-- <li class="nav-item active">
                <a href="#" class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px"
                    src="./files/${admin.profile_image}"
                    class="user-image"
                    alt="profile image"
                  /><span class="hidden-xs">${admin.first_name} ${admin.last_name}</span>
                </a>
              </li>  --%>
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
    <div class="container">
      <h2 class="h2-header">Category <i>${category.name}</i></h2>
      <div class="row">
        <table class="table table-bordered" style="width: 50% !important;">
          <tbody>
            <tr>
              <th scope="row">Category ID</th>
              <td>${category.id}</td>
            </tr>
            <tr>
              <th scope="row">Category Name</th>
              <td>${category.name}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="row video-table">
      <c:if test="${videos.size() > 0}">
        <h3 class="text-center">List of videos uploaded</h3>
        <table class="table table-bordered">
          <thead class="thead-dark">
            <tr>
              <th scope="row">Video ID</th>
              <th scope="row">User name</th>
              <th scope="row">Title</th>
              <th scope="row">Description</th>
              <th scope="row">Upload date</th>
              <th scope="row">Views</th>
              <th scope="row">Duration</th>
              <th scope="row">Privacy</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="v" items="${videos}">
              <tr>
                <td>${v.id}</td>
                <td>${v.user.user_name}</td>
                <td>${v.title}</td>
                <td>${v.description}</td>
                <td><fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${v.upload_date}" /></td>
                <td>${v.views}</td>
                <td>${v.duration}</td>
                <td>${v.privacy == 1 ? 'yes' : 'no'}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:if>

      <c:if test="${videos.size() == 0}">
        <div class="col-md-12 mt-4 text-center">
          <h3>No videos have been uploaded in this category</h3>
        </div>
      </c:if>
    </div>
      <footer class="main-footer mt-3">
      <div class="pull-right hidden-xs"><b>Version</b> 0.0.0.1</div>
      <strong
        >Copyright &copy; 2019
        <span style="color: #ff9999">AdminEmotube</span></strong     
      >
    </footer>
  </body>
</html>
