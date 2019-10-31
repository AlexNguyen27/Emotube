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

    .error {
      color: red;
      width: 100%;
      text-align: left;
      font-size: 14px;
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
        <h1 style="">List of Categories</h1>
     <!--    <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-user"></i> Admin</a></li>
          <li class="active"><a href="#">Categories</a></li>
        </ol> -->
        <button data-toggle="modal" data-target="#addCategoryModal" class="btn btn-success"
          style="margin-left: 10px; font-weight: bold"><i style="margin-right: 5px" class="fa fa-plus-circle"></i>Add
          new Category</button>
      </section>

      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-md-12">
            <!-- /.box -->
            <div class="box">
              <!-- /.box-header -->
              <div class="box-body" style="width: 100%; margin: 0 auto">
                <table class="table table-hover dataTable" id="example1" role="grid" aria-describedby="example1_info">
                  <thead class="thead-dark" style="background-color: #343A40; color: white;">
                    <tr>
                      <th>ID</th>
                      <th>Category Name</th>
                      <th style="text-align: center">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="c" items="${categories}">
                      <tr>
                        <td style="font-weight: bold">${c.id}</td>
                        <td>${c.name}</td>
                        <td align="center">
                          <a href="./admin/category/view-category/${c.id}.htm"
                            style="color: green; font-size: 18px; padding: 3px; padding-right: 10px"><i
                              class="fa fa-eye" aria-hidden="true"></i></a>
                          <a href="./admin/category/update-category/${c.id}.htm"
                            style="color: gray; font-size: 18px; padding: 3px; padding-right: 10px"><i
                              class="fas fa-pencil-alt"></i></a>
                          <a href="./admin/category/delete-category/${c.id}.htm" class="deleteBtn"
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
          <!-- /.box-body -->
        </div>
        <!-- /.box -->
          </section>
    </div>

    <!-- /.col -->
  </div>
  <!-- /.row -->

  <!-- /.content -->

  <!-- /.content-wrapper -->

  <!-- Footer -->
  <jsp:include page="./../include/footer.jsp"></jsp:include>

  <!-- end wrapper -->

  <!-- Add new user modal -->
  <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title" style="float: left" id="exampleModalLabel">Add a new Category</h3>
          <button type="button" style="float: right" onclick="location.href='./admin/category-list.htm'" class="close"
            data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <div style="clear: both;"></div>
        </div>
        <form:form action="admin/category-list.htm" modelAttribute="category">
          <div class="modal-body">
            <div class="form-group">
              <label class="col-form-label">Category name</label>
              <form:input path="name" placeholder="Enter Category Name" class="form-control" />
              <form:errors path="name" class="error" />
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-success">Save</button>
            <button type="button" onclick="location.href='./admin/category-list.htm'" class="btn btn-secondary"
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
  <!-- AdminLTE App -->
  <script src="${pageContext.request.contextPath}/resources/homePage/js/adminlte.min.js"></script>
  <!-- AdminLTE for demo purposes -->
  <script src="${pageContext.request.contextPath}/resources/homePage/js/demo.js"></script>
  <script>
    $(document).ready(function () {
      $('.menu').on('click', function () {
        $('.menu').removeClass('active');
        $(this).addClass('active');
      });
    });

  </script>
  <!-- page script, dont need this time-->
  <script>
    $(function () {
      $('#example1').DataTable()
    /*   $('#example2').DataTable({
        'paging': true,
        'lengthChange': false,
        'searching': false,
        'ordering': true,
        'info': true,
        'autoWidth': false
      }) */
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
  <c:if test="${openModal == 'yes'}">
    <script>
      $(window).on('load', function () {
        $('#addCategoryModal').modal('show');
      });
    </script>
  </c:if>
  <script>
    $('.removeError').on('click', function () {
      $('.error').remove();
    });
  </script>
</body>

</html>