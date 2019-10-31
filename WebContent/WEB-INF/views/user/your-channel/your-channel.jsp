<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<base href="${pageContext.servletContext.contextPath}/" />
	<title>Emotube</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
	<!-- Bootstrap 3.3.7 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/font-awesome.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/ionicons.min.css" />
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/homePage/css/dataTables.bootstrap.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/home-user.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/_all-skins.min.css" />

	<!-- Google Font -->
	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic" />
	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
	<style>
	
		@media only screen and (min-width: 1200px) {
			.duration {
				top: 52%;
				right: 9%;
				position: absolute;
				text-align: right;
				border: 1px solid black;
				background: black;
				color: #f9f9f9;
			}
		}

		.thumbnail {
			padding-right: 15px;
			border: none;
			cursor: pointer;
		}

		.skin-blue .sidebar-menu>li.active>a {
			border: none !important;
		}

		div.user-panel {
			padding: 14px !important;
		}

		.card-title {
			font-size: 15px;
			margin-top: 7px;
			font-weight: bold;
			display: block !important;
		}

		.card-img-top {
			position: relative;
		}

		.duration {
			position: absolute;
			text-align: right;
			border: 1px solid black;
			background: black;
			color: #f9f9f9;
			top: 47%;
			right: 8%;
		}

		.card-text {
			margin: 0px;
			font-size: 13px;
			color: gray;
		}

		img {
			width: 100% !important;
		}

		.user_info {
			padding: 15px 50px 15px 50px;
			background-color: #444f5a;
			color: #F9F9F9;
			margin: 0px 0px 15px 0px;
			letter-spacing: 0.5px;
		}

		.vcenter {
			display: inline-block;
			vertical-align: middle;
			float: none;
		}

		.select_category {
			padding: 2px 1px 4px 16px;
			margin-left: 14px;
			box-shadow: none !important;
			border-radius: 15px;
			outline: none !important;
		}

		.error {
			color: red;
			width: 100%;
			text-align: left;
			font-size: 14px;
		}

		li a span {
			width: 175px;
		}
	</style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<jsp:include page="./../include/header.jsp">
			<jsp:param value="${user.first_name} ${user.last_name}" name="fullname" />
      	 	<jsp:param value="${user.profile_image}" name="profile_image" />
    	</jsp:include>

		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="./files/${user.profile_image}"
							class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>${user.first_name}${user.last_name}</p>
						<span style="font-size: 11px"><i class="fa fa-circle text-success"></i> Online</span>
					</div>
				</div>
			<!-- search form -->
		        <div class="sidebar-form">
		          <div class="input-group">
		            <input type="text" id="myInput" placeholder="Search for all..." class="form-control" />
		            <span class="input-group-btn">
		              <button type="button" name="search" id="search-btn" class="btn btn-flat">
		                <i class="fa fa-search"></i>
		              </button>
		            </span>
		          </div>
		        </div>
       			 <!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">MAIN SECTION</li>
					<li class="menu"><a href="user/your-channel.htm"> <i class="fa fa-user"></i> <span>Your
								channel</span>
						</a></li>
					<li class="treeview"><a href="#"> <i class="fa fa-folder"></i>
							<span>Categories</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<c:forEach var="c" items="${categories}">
								<li><a href="./user/category/view-video/${c.id}.htm"><i
											class="fa fa-fire"></i>${c.name}</a></li>
							</c:forEach>
						</ul>
					</li>

					<li class="menu"><a href="log-out.htm"> <i class="fas fa-sign-out-alt"></i> <span>Log out</span>
						</a></li>
					<li class="header">MORE</li>
					<li><a href="user/help.htm"><i class="fa fa-question"></i> <span>Help</span></a>
					</li>
					<li><a><i class="fa fa-comments"></i> <span>Send feedback</span></a></li>
					<li><a><i class="fa fa-cogs"></i> <span>Settings</span></a>
					</li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="min-height: 600px !important">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="row user_info">
					<div class="col-md-3 vcenter" style="width: 23%">
						<img style="border: 3px solid;"
							src="./files/${user.profile_image}"
							class="img-circle" alt="User Image" />
					</div>
					<div class="col-md-5 vcenter">
						<p style="font-weight: bold; font-size: 25px">
							${user.first_name} ${user.last_name}</p>
						<p>
							<b><i> ${user.email}</i></b>
						</p>
							<p>
							Total number of videos uploaded: <span style="font-weight: bold">${videos.size()}</span>
						</p>
						<p style="font-weight: bold">
							${user.subscribes_to.size()} ${user.subscribes_to.size() > 1 ? 'Subscribers' : 'Subscriber'}
						</p>
					
						<button class="btn btn-info" style="margin-right: 10px; margin-top: 10px; weight: bold" onclick="location.href='./user/update-info/${user.id}.htm'">
							<i style="margin-right: 5px" class="fas fa-pencil-alt"></i>Update Your Profile
						</button>
						<button class="btn btn-warning" style="margin-top: 10px; weight: bold" onclick="location.href='./user/change-password/${user.id}.htm'">
						<i  style="margin-right: 5px"class="fas fa-key"></i>Change password
						</button>
							<button data-toggle="modal" data-target="#addVideoModal" class="btn btn-success"
							style="margin-top: 10px;margin-right: 10px; weight: bold">
							<i style="margin-right: 5px" class="fa fa-plus-circle"></i>Add
							new Video
						</button>
					</div>
					<div class="col-md-4 vcenter" style="width: 30%">
						<img src="./resources/image/logo_channel.png" alt="User Image" />
					</div>
				</div>
			</section>
			<section class="content">
				<div class="row justify-content-md-center" style="margin-left: auto;" id="myVideo">
					<c:if test="${videos.size() <= 0}">
							<h3 style="text-align: center; font-size: 22px; font-style: italic">Add new video to view your video</h3>
					</c:if>
					<c:forEach var="v" items="${videos}">
						<div class="card col-md-3 thumbnail" id="video">
							<div title="${v.description}" data-toggle="tooltip" data-placement="bottom"
								style="background-color: #F9F9F9"
								<%-- onclick="window.open('./user/view-video/${v.id}.htm', '_blank');" --%>
								onclick="location.href='./user/view-video/${v.id}.htm'"
								>
								<img src="${v.image_url}" class="card-img-top" alt="url_image" />
								<h5 class="duration">${v.duration}</h5>
								<div class="card-body" style="padding-left: 5px">
									<div>
										<h5 class="card-title" style="text-align: left; display: inline">${v.title}</h5>
									</div>
							
									<p class="card-text">${v.views} ${v.views > 1 ? "views" : "view"}  <i>(Public: ${v.privacy==0 ? ' yes' : 'no'})</i></p>

								</div>
							</div>
							<div style="text-align: right">
								<a href="./user/user-${user.id}/update-video/${v.id}.htm"
									style="color: gray; font-size: 15px; padding: 3px; padding-right: 10px"><i
										class="fas fa-pencil-alt"></i><span> Edit</span></a>
								<a href="./user/user-${user.id}/delete-video/${v.id}.htm"
									style="color: red; font-size: 15; padding: 3px" class="deleteBtn"><i class="fa fa-trash"
										aria-hidden="true"></i><span> Delete</span></a>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
			<!-- /.content -->
		</div>

		<!-- /.content-wrapper -->
		<jsp:include page="./../include/footer.jsp"></jsp:include>
		
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
				<form:form action="./user/user-${user.id}/add-video.htm" modelAttribute="video">
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
									<form:radiobutton path="privacy" value="0" checked="checked" label="No"
										style="font-weight: none!important" />
								</div>
								<div class="col-md-5" style="padding-top: calc(.375rem + 1px)">
									<form:radiobutton path="privacy" value="1" label="Yes" />
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

	<!-- SCRIPT -->
	<script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/homePage/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/homePage/js/dataTables.bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.slimscroll.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/homePage/js/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="${pageContext.request.contextPath}/resources/homePage/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="${pageContext.request.contextPath}/resources/homePage/js/demo.js"></script>
	<script>
		$('.removeError').on('click', function () {
			$('.error').remove();
		});
	</script>
	<c:if test="${openModal == 'yes'}">
		<script>
			$(function () {
				$(window).on('load', function () {
					$('#addVideoModal').modal('show');
				});
			})
		</script>
		
	</c:if>
	<script>
			$(function () {
				$(document).ready(function () {
					$('[data-toggle="tooltip"]').tooltip();
				});
			})	
		</script>
		
	<script>
	$(function() {
		$(document).ready(function() {
			$(".deleteBtn").click(function(){
				if (!confirm("Are you sure you want to delete this?\nYou won't be able to revert this!")){
				      return false;
				    }
			  });
		});
	})
	</script>
	<script>
		$(document).ready(function(){
		  $("#myInput").on("keyup", function() {
		    var value = $(this).val().toLowerCase().trim();
		    console.log(value);
		    $("#myVideo #video").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		});
	</script>
</body>

</html>