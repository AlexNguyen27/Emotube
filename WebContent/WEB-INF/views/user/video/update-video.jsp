<%@ page pageEncoding="utf-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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

      .select_category {
        padding: 2px 1px 4px 16px;
        margin-left: 14px;
        box-shadow: none !important;
        border-radius: 15px;
        outline: none !important;
      }

      input,
      textarea {
        border-radius: 15px !important;
        outline: none !important;
        box-shadow: none !important;
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
            <li class="nav-item active">
              <a class="nav-link" href="${user.role=='admin' ? 'admin/admin-info.htm' : 'user/your-channel.htm'}"
                >Your Channel<span class="sr-only">(current)</span></a
              >
            </li>
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
   
    <div class="container">
      <h2 class="h2-header">Edit video <i>${video.title}</i></h2>
      <form:form
        action="user/user-${userId}/update-video/${id}.htm"
        modelAttribute="video"
      >
        <div class="modal-body" style="padding-top: 0px">
          <div class="form-group">
            <label class="col-form-label">Title</label>
            <form:input
              path="title"
              placeholder="Enter Video Title"
              class="form-control"
            />
            <form:errors path="title" class="error"></form:errors>
          </div>

          <div class="form-group">
            <label class="col-form-label">Description</label>
            <form:textarea
              path="description"
              placeholder="Enter Video Description"
              rows="2"
              cols="30"
              class="form-control"
            />
            <form:errors path="description" class="error"></form:errors>
          </div>

          <div class="form-group row">
            <div class="col-md-2">
              <label class="col-form-label">Privacy:</label>
            </div>
            <div class="col-md-3" style="padding-top: calc(.375rem + 1px)">
              <form:radiobutton
                path="privacy"
                value="1"
                checked="${video.privacy==1 ? 'checked' : ''}"
                label="Yes"
                style="font-weight: none!important"
              />
            </div>
            <div class="col-md-3" style="padding-top: calc(.375rem + 1px)">
              <form:radiobutton
                path="privacy"
                checked="${video.privacy==0 ? 'checked' : ''}"
                value="0"
                label="No"
              />
            </div>
          </div>

          <div class="form-group">
            <label class="col-form-label">Category:</label>
            <form:select path="category.id" class="select_category">
              <c:forEach var="c" items="${categories}">
                <form:option value="${c.id}" label="${c.name}" />
              </c:forEach>
            </form:select>
          </div>

          <div class="form-group">
            <label class="col-form-label">Image URL</label>
            <form:input
              readonly="true"
              path="image_url"
              placeholder="Enter Image URL"
              class="form-control"
            />
            <form:errors path="image_url" class="error"></form:errors>
          </div>
          <div class="form-group">
            <label class="col-form-label">Video URL</label>
            <form:input
              readonly="true"
              path="video_url"
              placeholder="Enter Video URL"
              class="form-control"
            />
            <form:errors path="video_url" class="error"></form:errors>
          </div>

          <div class="form-group row">
            <div class="col-md-6">
              <label class="col-form-label">Duration</label>
              <form:input
                readonly="true"
                path="duration"
                placeholder="Enter Video Duration"
                class="form-control"
              />
            </div>
            <div class="col-md-6">
              <label class="col-form-label">Views</label>
              <form:input
                path="views"
                readonly="true"
                class="form-control"
                value="${video.views}"
              />
            </div>
          </div>
        </div>
        <div class="mt-2 pl-3 mb-3">
          <button type="submit" class="btn btn-success">Save</button>
          <button
            type="button"
            onclick="location.href='./user/your-channel.htm'"
            class="btn btn-secondary"
            data-dismiss="modal"
            >Cancel</button
          >
        </div>
      </form:form>
    </div>
    
     <jsp:include page="./../include/footer.jsp">
     	<jsp:param value="${user.role}" name="userRole"/>
     </jsp:include>
  </body>
</html>
