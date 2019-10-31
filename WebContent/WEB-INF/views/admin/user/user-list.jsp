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
  <style>
    .skin-blue .sidebar-menu>li.active>a {
      border: none !important;
    }

    .wrapper {
      height: auto;
    }

    div.dataTables_wrapper div.dataTables_paginate {
      font-size: 15px !important;
    }

    table.dataTable thead .sorting:after {
      content: "" !important;
    }

    table.dataTable thead .sorting_asc:after {
      content: "\2713";
    }

    div.user-panel {
      padding: 14px !important;
    }

    .error {
      color: red;
      width: 100%;
      text-align: left;
      font-size: 14px;
    }

    .error-head {
      text-align: center;
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
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <h1 style="">List of Users</h1>
       <!--  <ol class="breadcrumb">
          <li ><i class="fa fa-user"></i> Admin</li>
          <li>Users</li>
        </ol> -->
        <button data-toggle="modal" data-target="#addUserModal" class="btn btn-success"
          style="margin-left: 10px;font-weight: bold"><i style="margin-right: 5px" class="fas fa-plus-circle"></i>Add
          new User</button>
      </section>
      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-xs-12">
            <!-- /.box -->

            <div class="box">

              <!-- /.box-header -->
              <div class="box-body">
                <table class="table table-hover dataTable" id="example1" role="grid" aria-describedby="example1_info">
                  <thead class="thead-dark" style="background-color: #343A40; color: white;">
                    <tr>
                      <th>ID</th>
                      <th>Username</th>
                      <th>First Name</th>
                      <th>Last Name</th>
                      <th>Email</th>
                      <th>Role</th>
                      <th style="text-align: center">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="u" items="${users}">
                      <tr>
                        <td style="font-weight: bold">${u.id}</td>
                        <td>${u.user_name}</td>
                        <td>${u.first_name}</td>
                        <td>${u.last_name}</td>
                        <td>${u.email}</td>
                        <td>${u.role}</td>
                        <td align="center">
                          <a href="./admin/user/view-user/${u.id}.htm"
                            style="color: green; font-size: 18px; padding: 3px; padding-right: 10px"><i
                              class="fa fa-eye" aria-hidden="true"></i></a>
                          <a href="./admin/user/update-user/${u.id}.htm"
                            style="color: gray; font-size: 18px; padding: 3px; padding-right: 10px"><i
                              class="fas fa-pencil-alt"></i></a>
                          <a href="./admin/user/delete-user/${u.id}.htm" class="deleteBtn"
                            style="color: red; font-size: 18px; padding: 3px"><i class="fa fa-trash"
                              aria-hidden="true"></i></a>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                  <tfoot>
                  </tfoot>
                </table>
              </div>
              <!-- /.box-body -->
            </div>
            <!-- /.box -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </section>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Footer -->
    <jsp:include page="./../include/footer.jsp"></jsp:include>
  </div>
  <!-- end wrapper -->

  <!-- Add new user modal -->
  <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title" style="float: left" id="exampleModalLabel">Add a new user</h3>
          <button type="button" style="float: right" onclick="location.href='./admin/user-list.htm'" class="close"
            data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <div style="clear: both;"></div>
        </div>
        <form:form action="admin/user-list.htm" modelAttribute="user" enctype="multipart/form-data">
          <div class="modal-body">
            <div class="form-group">
              <label class="col-form-label">Username</label>
              <form:input path="user_name" placeholder="Enter User Name" class="form-control" />
              <form:errors path="user_name" class="error" />
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-md-6">
                  <label class="col-form-label">First Name</label>
                  <form:input path="first_name" placeholder="Enter First Name" class="form-control" />
                  <form:errors path="first_name" class="error" />
                </div>
                <div class="col-md-6 ml-auto">
                  <label class="col-form-label">Last Name</label>
                  <form:input path="last_name" placeholder="Enter Last Name" class="form-control" />
                  <form:errors path="last_name" class="error" />
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-form-label">Email</label>
              <form:input type="email" path="email" placeholder="Enter Email" class="form-control" />
              <form:errors path="email" class="error" />
            </div>
            <div class="form-group">
              <label class="col-form-label">Profile Image</label>
               	<input type="file" name="profile" placeholder="Profile image"  class="form-control"/>
          		 <form:errors path="profile_image" class="error" />
            </div>
            <div class="form-group">
              <!--  <label class="col-form-label">Role</label> <br> -->
              <div class="row">
                <div class="col-md-2">
                  <label class="col-form-label">Role:</label>
                </div>
                <div class="col-md-5">
                  <form:radiobutton path="role" value="admin" label="Admin" style="font-weight: none!important" />
                </div>
                <div class="col-md-5">
                  <form:radiobutton path="role" value="user" checked="checked" label="User" />
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-form-label">Password</label>
              <form:password path="password" placeholder="Enter Password" class="form-control" />
              <form:errors path="password" class="error" />
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" onclick="modelopen" class="btn btn-success">Save</button>
            <button type="button" onclick="location.href='./admin/user-list.htm'" class="btn btn-secondary removeError"
              data-dismiss="modal">Close</button>
          </div>
        </form:form>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/dataTables.bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/jquery.slimscroll.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/fastclick.js"></script>
  <script src="${pageContext.request.contextPath}/resources/homePage/js/adminlte.min.js"></script>
 

  <!-- page script, dont need this time-->
  <c:if test="${openModal == 'yes'}">
    <script>
      $(window).on('load', function () {
        $('#addUserModal').modal('show');
      });
    </script>
  </c:if>
  
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
    $(function () {
      $('#example1').DataTable()
    })
  </script>
  <!--  <script>
	  function modelopen(){
			var temp = document.getElementByClassName("error").innerHTML;
		 	if(temp!==""){
		    	/* $('#addUserModal').modal('show'); */
		 		$(window).on('load',function(){
		 	        $('#addUserModal').modal('show');
		 	    }); $('#addUserModal').modal({backdrop: 'static', keyboard: false})  
			};
		 	$(document).ready(function () {
		 	    $('.menu').on('click', function () {
		 	        $('.menu').removeClass('active');
		 	        $(this).addClass('active');
		 	    });  <script>
  	
  $('.modal').on('close', function(e) {        
	   // Submit data to server and in success callback write if to validate whether form data is valid or not . 
	    var temp = document.getElementByClassName("error").innerHTML;
	   if(temp!=="") {           
	          e.preventDefault();
	          $('#addUserModal').modal('show');
	    }
	});
 
  </script>
		 	});
  </script> -->
  <!-- 	<!-- <script type="text/javascript">
    $(window).on('load',function(){
        $('#addUserModal').modal('show');
    }); -->

</body>

</html>