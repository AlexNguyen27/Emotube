<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <base href="${pageContext.servletContext.contextPath}/">
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
      top: 50%;
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
  </style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper">
    <jsp:include page="./include/header.jsp" >
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
            <img src="./files/${user.profile_image}" class="img-circle"
              alt="User Image" />
          </div>
          <div class="pull-left info">
            <p>${user.first_name} ${user.last_name}</p>
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

          <li class="menu">
            <a href="user/your-channel.htm"> <i class="fa fa-user"></i> <span>Your channel</span> </a>
          </li>
          <li class="treeview">
            <a href="#">
              <i class="fa fa-folder"></i> <span>Categories</span>
              <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>

            </a>
            <ul class="treeview-menu">
              <c:forEach var="c" items="${categories}">
                <li><a href="./user/category/view-video/${c.id}.htm"><i class="fa fa-fire"></i>${c.name}</a></li>
              </c:forEach>
            </ul>
          </li>

          <li class="menu">
            <a href="log-out.htm">
              <i class="fas fa-sign-out-alt"></i> <span>Log out</span>
            </a>
          </li>

          <li class="header">MORE</li>
          <li>
            <a href="user/help.htm"><i class="fa fa-question"></i> <span>Help</span></a>
          </li>
          <li>
            <a href="user/send-feedback.htm"><i class="fa fa-comments"></i> <span>Send feedback</span></a>
          </li>
          <li>
            <a><i class="fa fa-cogs"></i> <span>Settings</span></a>
          </li>
        </ul>
      </section>
      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->

    <div class="content-wrapper" style="min-height: 600px !important">

      <section class="content-header">
        <div style="padding-bottom: 15px">
          <img src="./resources/image/facebook_cover.png" alt="emotube_logo" />
        </div>

      </section>
      <section class="content">
        <div class="row justify-content-md-center" style="margin-left: auto; " id="myVideo">
          <c:forEach var="v" items="${videos}" >
            <div id="video" class="card col-md-3 thumbnail" data-toggle="tooltip" data-videoID="${v.id}" data-placement="bottom"
              title="${v.description}" onclick="location.href='./user/view-video/${v.id}.htm'">
              <div style="background-color: #F9F9F9">
                <img src="${v.image_url}" class="card-img-top" alt="url_image" />
                <h5 class="duration">${v.duration}</h5>
                <div class="card-body" style="padding-left: 5px">
                  <!--  <div> -->
                  <h5 class="card-title" id="title" style="text-align: left; display: inline">${v.title}</h5>
                  <!-- </div> -->

                  <%--  <p class="card-text">${v.description}</p> --%>
                  <p class="card-text">${v.views} ${v.views > 1 ? 'views' : 'view'}</p>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </section>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    
     <jsp:include page="./include/footer.jsp">
     <jsp:param value="${user.role}" name="userRole"/>
     </jsp:include>

   
  </div>
  <!-- ./wrapper -->

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

  <!-- page script -->
 <script>
    $(function () {
      $('#example1').DataTable();
      $('#example2').DataTable({
        paging: true,
        lengthChange: false,
        searching: false,
        ordering: true,
        info: true,
        autoWidth: false
      });
    });
  </script> 
  <script>
    $(document).ready(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });
  </script>

  <!-- <script>
	$(document).ready(function() {
		 $(".thumbnail").click(function(){
			 var xhr = new XMLHttpRequest();
			 $.get("./user/like-video/" + $(this).attr("data-videoID")+ ".htm", function(data, status){
				 
				 
			 }
			 
		 }
			
	})
</script> -->

<script>
/* $(document).ready(function() {
	 $("#myInput").keyup(function(){
		 var input, filter, div, video, a, i, txtValue;
		    input = $('#myInput').val();
		    console.log(input);
		    
		    filter = input.value.toUpperCase();
		    div = document.getElementById("myVideo");
		    video = div.getElementById("video");
		    
		    for (i = 0; i < li.length; i++) {
		        a = video[i].getElementById("title")[0];
		        txtValue = a.textContent || a.innerText;
		        if (txtValue.toUpperCase().indexOf(filter) > -1) {
		            video[i].style.display = "";
		        } else {
		            video[i].style.display = "none";
		        }
		    }
		 
	 })
		
})
 */
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