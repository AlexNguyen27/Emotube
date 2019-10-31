<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<base href="${pageContext.servletContext.contextPath}/">
	<title>Emotube</title>
	<link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./bootstrap/js/jquery-min.js"></script>

	<script type="text/javascript" src="./bootstrap/js/bootstrap.min.js"></script>
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
			margin-top: .5rem;
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

		.addButton {
			margin-left: 10px;
			font-weight: bold;
			padding: 0px 10px;
			margin: 20px 10px 6px 10px;
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
              <a class="nav-link" href="admin/user-list.htm"
                >Users<span class="sr-only">(current)</span></a
              >
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <ul class="navbar-nav mr-auto">
             <%--  <li class="nav-item active">
                <a href="#" class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px"
                    src="./files/${admin.profile_image}"
                    class="user-image"
                    alt="profile image"
                  /><span class="hidden-xs">${admin.first_name} ${admin.last_name}</span>
                </a>
              </li> --%>
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
		<h2 class="h2-header mb-3">
			User <i>${user.user_name}</i>
		</h2>
		<div class="row">
			<div class="col-md-4">
				<img src="./files/${user.profile_image}"
					width="100%" height="295px" alt="profile image" />
			</div>
			<div class="col-md-8">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th scope="row">User ID</th>
							<td>${user.id}</td>
						</tr>
						<tr>
							<th scope="row">UserName</th>
							<td>${user.user_name}</td>
						</tr>
						<tr>
							<th scope="row">First Name</th>
							<td>${user.first_name}</td>
						</tr>
						<tr>
							<th scope="row">Last Name</th>
							<td>${user.last_name}</td>
						</tr>
						<tr>
							<th scope="row">Email</th>
							<td>${user.email}</td>
						</tr>
						<tr>
							<th scope="row">Role</th>
							<td>${user.role}</td>
						</tr>

					</tbody>

				</table>
			</div>
		</div>

	</div>

	<div class="row video-table">
		<c:if test="${videos.size() > 0}">
			<h3 class="text-center mt-3">Videos uploaded</h3>
			<button data-toggle="modal" data-target="#addVideoModal" class="btn btn-success addButton"><i
					style="margin-right: 5px" class="fa fa-plus-circle"></i>Add new Video</button>
			<table class="table table-bordered">
				<thead class="thead-dark">
					<tr>
						<th scope="row">Video ID</th>
						<th scope="row">Category name</th>
						<th scope="row">Title</th>
						<th scope="row" style="width: 26%;">Description</th>
						<th scope="row">Upload date</th>
						<th scope="row">Views</th>
						<th scope="row">Duration</th>
						<th scope="row">Privacy</th>
						<th style="text-align: center" scope="row">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="v" items="${videos}">
						<tr>
							<td>${v.id}</td>
							<td>${v.category.name}</td>
							<td style="width: 12%;">${v.title}</td>
							<td>${v.description}</td>
							<td><fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${v.upload_date}" /></td>
							<td>${v.views}</td>
							<td>${v.duration}</td>
							<td>${v.privacy == 1 ? 'yes' : 'no'}</td>
							<td align="center">
								<a href="./admin/user-${user.id}/update-video/${v.id}.htm"
									style="color: gray; font-size: 20px; padding: 3px"><i
										class="fas fa-pencil-alt"></i></a>
								<a href="./admin/user-${user.id}/delete-video/${v.id}.htm"
									style="color: red; font-size: 20px; padding: 3px"><i class="fa fa-trash"
										aria-hidden="true"></i></a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

		<c:if test="${videos.size() == 0}">
			<div class="col-md-12 mt-4 text-center">
				<h3>No videos have been uploaded in from this user</h3>
				<button data-toggle="modal" data-target="#addVideoModal" class="btn btn-success addButton pt-1 pb-1 pl-3 pr-3"><i
						 class="fa fa-plus-circle"></i> Add new Video</button>
			</div>
		</c:if>
	</div>

	<!-- Add new user modal -->
	<div class="modal fade" id="addVideoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" style="max-width: 45%;" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" style="float: left; text-align: center" id="exampleModalLabel">Add new Video
					</h3>
					<button type="button" style="float: right" class="close removeError" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<div style="clear: both;"></div>
				</div>
				<form:form action="./admin/user/view-user/${user.id}.htm" modelAttribute="video">
					<div class="modal-body" style="padding-top: 0px">
						<div class="form-group">
							<label class="col-form-label">Title</label>
							<form:input path="title" placeholder="Enter Video Title" class="form-control" />
							<form:errors path="title" class="error"></form:errors>
						</div>
						<div class="form-group">
							<label class="col-form-label">Description</label>
							<form:textarea path="description" placeholder="Enter Video Description" rows="2" cols="30"
								class="form-control" />
							<form:errors path="description" class="error"></form:errors>
						</div>
						<%-- <div class="form-group">
							<label class="col-form-label">Image URL</label>
							<form:input path="image_url" placeholder="Enter Image URL" class="form-control" />
							<form:errors path="image_url" class="error"></form:errors>
						</div> --%>
						<div class="form-group">
							<label class="col-form-label">Video URL</label>
							<form:input path="video_url" placeholder="Enter Video URL" class="form-control" />
							<form:errors path="video_url" class="error"></form:errors>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-md-2">
									<label class="col-form-label">Privacy:</label>
								</div>
								<div class="col-md-5" style="padding-top: calc(.375rem + 1px)">
									<form:radiobutton path="privacy" checked="checked" value="0" label="No" />
								</div>
								<div class="col-md-5" style="padding-top: calc(.375rem + 1px)">
									<form:radiobutton path="privacy" value="1"  label="Yes"
										style="font-weight: none!important" />
								</div>
								
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
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success">Save</button>
						<button type="button" class="btn btn-secondary removeError" data-dismiss="modal">Close</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
 	<jsp:include page="./../../user/include/footer.jsp">
    	<jsp:param value="${admin.role}" name="userRole"/>
    </jsp:include>
</body>

<script>
	$('.removeError').on('click', function () {
		$('.error').remove();
	});
</script>
<c:if test="${openModal == 'yes'}">
	<script>
		$(window).on('load', function () {
			$('#addVideoModal').modal('show');
		});
	</script>
</c:if>

</html>