<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <base href="${pageContext.servletContext.contextPath}/">
  <title>Emotube</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/font-awesome.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/ionicons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/dataTables.bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/home-admin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homePage/css/_all-skins.min.css">

  <!-- Google Font -->
  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
  <!-- <script src="https://use.fontawesome.com/b4bf5040c4.js"></script>  -->
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
			right: 10%;
		}

		.card-text {
			margin: 0px;
			font-size: 13px;
			color: gray;
		}

		.user_info {
			padding: 15px 50px 48px 50px;
			background-color: #444f5a; 
			color: #F9F9F9;
			margin: 0px 0px 15px 0px;
			letter-spacing: 0.5px;
		}

		.vcenter {
			display: inline-block;
			vertical-align: middle;
			float: none;
			height: 100%;
		}

		.select_category {
			padding: 2px 1px 4px 16px;
			margin-left: 14px;
			box-shadow: none !important;
			border-radius: 15px;
			outline: none !important;
		}
		.user_info img {
			width: 100% !important;
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
		.content-header {
			 position: relative;
		}
		.content img {
			width: 100% !important;
		}
  </style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper">
    <!-- header -->
    <jsp:include page="./../include/header.jsp">
      <jsp:param value="${admin.first_name} ${admin.last_name}" name="fullname" />
       <jsp:param value="${admin.profile_image}" name="profile_image" />
    </jsp:include>

    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="./../include/sidebar.jsp">
      <jsp:param value="${admin.first_name} ${admin.last_name}" name="fullname" />
      <jsp:param value="${admin.profile_image}" name="profile_image" />
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
   <div class="content-wrapper" style="min-height: 600px !important">
			<!-- Content Header (Page header) -->
		 <section class="content-header">
   		<!--  <div style="padding-bottom: 15px">
          <img src="./resources/image/facebook_cover.png" style="width: 100%"alt="emotube_logo" />
        </div> 	-->
      </section>
			<section class="content">
				<div class="row user_info">
					<div class="col-md-3" style=" margin-top: 31px">
						<img style="border: 3px solid;"
							src="./files/${admin.profile_image}"
							class="img-circle" alt="User Image" />
					</div>
					<div class="col-md-5" style=" margin-top: 51px;">
						<p style="font-weight: bold; font-size: 25px">
							${admin.first_name} ${admin.last_name}
						</p>
						<p>
							Email: <b><i> ${admin.email}</i></b>
						</p>
						<p>
							Total number of videos uploaded: <span style="font-weight: bold">${videos.size()}</span>
						</p>
						<p style="font-weight: bold">
							${admin.subscribes_to.size()} ${admin.subscribes_to.size() > 1 ? 'Subscribers' : 'Subscriber'}
						</p> 
						<button class="btn btn-info" style="margin-top: 10px; weight: bold; margin-right: 10px" onclick="location.href='./admin/update-info/${admin.id}.htm'">
							<i style="margin-right: 5px" class="fas fa-pencil-alt"></i>Update Your Profile
						</button>
						<button class="btn btn-warning" style="margin-top: 10px; weight: bold" onclick="location.href='./admin/change-password/${admin.id}.htm'">
							<i  style="margin-right: 5px"class="fas fa-key"></i>Change password
						</button>
					</div>
					 <div class="col-md-4 vcenter" style="width: 30%;"> 
						<img src="./resources/image/logo_channel.png" alt="User Image" />
					</div>
				</div>
			</section>
			<section class="content">
				<c:if test="${videos.size() <= 0}">
					<h3 style="text-align: center; font-size: 22px; font-style: italic">Add new video to view your video</h3>
				</c:if>
				<div class="row justify-content-md-center" style="margin-left: auto;">
					<c:forEach var="v" items="${videos}">
						<div class="card col-md-3 thumbnail">
							<div title="${v.description}" data-toggle="tooltip" data-placement="bottom"
								style="background-color: #F9F9F9"
								onclick="window.open('./user/view-video/${v.id}.htm', '_blank');">
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
								<a href="./admin/user-${admin.id}/update-video/${v.id}.htm"
									style="color: gray; font-size: 15px; padding: 3px; padding-right: 10px"><i
									class="fas fa-pencil-alt"></i><span> Edit</span></a>
								<a href="./admin/user-${admin.id}/delete-video/${v.id}.htm" class="deleteBtn"
									style="color: red; font-size: 15; padding: 3px"><i class="fa fa-trash"
									aria-hidden="true"></i><span> Delete</span></a>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
		<!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Footer -->
    <jsp:include page="./../include/footer.jsp"></jsp:include>
  </div>
  <!-- end wrapper -->


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
</body>

</html>