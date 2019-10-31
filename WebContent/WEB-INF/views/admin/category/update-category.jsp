<%@ page pageEncoding="utf-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>
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
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
    <style>
      .form-group {
        margin-bottom: 0px;
      }

      .container {
        width: 70%;
        margin: 0 auto;
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

      .error {
        color: red;
        width: 100%;
        text-align: left;
        font-size: 14px;
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

    footer {
      position: fixed;
      bottom: 0;
      width: 100%;
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
      <h2 class="h2-header">Edit Category</h2>
      <form:form
        action="admin/category/update-category/${category.id}.htm"
        modelAttribute="category"
      >
        <div class="form-group">
          <label class="col-form-label">Category ID</label>
          <form:input
            path="id"
            value="${category.id}"
            readonly="true"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label class="col-form-label">Category name</label>
          <form:input
            path="name"
            value="${category.name}"
            class="form-control"
          />
          <form:errors path="name" class="error" />
        </div>

        <div class="mt-2">
          <button type="submit" class="btn btn-success">Save</button>
          <button
            type="button"
            onclick="location.href='./admin/category-list.htm'"
            class="btn btn-secondary"
            data-dismiss="modal"
            >Cancel</button
          >
        </div>
      </form:form>
    </div>
   	<jsp:include page="./../../user/include/footer.jsp">
    	<jsp:param value="${user.role}" name="userRole"/>
    </jsp:include>
  </body>
</html>
