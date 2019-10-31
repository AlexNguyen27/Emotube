<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<base href="${pageContext.servletContext.contextPath}/" />
	<title>Emotube</title>
	<link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

	<script type="text/javascript" src="./bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
</head>

<style>
	.wrapper {
		margin-top: 10px;
		margin-left: 30px;
		margin-right: 30px;
	}

	.video-text {
		font-size: 13px;
		margin: 0px;
		color: gray
	}

	.video-description {
		font-size: 14px;
		margin: 0px;
		font-style: italic;
	}

	.video-like,
	.video-dislike {
		cursor: pointer;
		padding: 20px 20px 20px 8px;
	}

	.like-btn,
	.dislike-btn {
		cursor: pointer;
	}

	.col-md-4 i {
		font-size: 18px;
		color: #909090;
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

<body>

	  <header>
      <nav
        class="navbar navbar-expand-lg navbar-dark bg-dark pt-1 pb-1"
        style="background-color:#374850!important;"
      >
        <a class="navbar-brand" style="  color: #ff9999 !important;" href="${user.role=='admin' ? 'admin/user-list.htm' : 'user/home.htm'}"
          ><b>${user.role == 'admin' ? 'AdminEMOTUBE' : "EMOTUBE"}</b></a
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
                <a  class="nav-link pr-4">
                  <img
                    style="width: 38px; padding-right: 10px; border-radius: 50%;"
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
	<div class="wrapper pt-3">
		<div class="row">
			<div class="col-md-7 pl-1">
				<iframe width="100%" height="409" src="https://www.youtube.com/embed/${video.video_url}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				<div style="background-color: #f9f9f9" class="pl-3 pr-3">
					<h4 class="mt-2">${video.title}</h4>
					<div class="row">
						<div class="col-md-8">
							<p class="video-description ">${video.description}</p>
							<span class="video-description mr-2">${video.views} ${video.views > 1 ? 'views' : 'view'}
							</span>
							<span class="video-description">
								<fmt:formatDate type="date" value="${video.upload_date}" /></span>
						</div>
						<div class="col-md-4">
							<i class="fas fa-thumbs-up like-btn" data-videoID="${video.id}"></i><span
								class="video-like">${likes.size()}</span>
							<i class="fas fa-thumbs-down dislike-btn" data-videoID="${video.id}"></i><span
								class="video-dislike">${dislikes.size()}</span>
							<%-- <a href="./user/dislike-video/${video.id}.htm"><i class="fas fa-thumbs-down"></i></a><span class="video-dislike">${video.dislikes.size()}</span> --%>
						</div>
					</div>
					
				</div>
				<div class="row mt-3"> 
					<div class="col-md-9">
						<img style="border-radius: 50%; width: 8%;" src="./files/${video.user.profile_image}"/>
    					<h4 style="vertical-align: middle;display: inline; padding-top: 16px;padding-left: 8px;font-size: 21px;">${video.user.last_name} ${video.user.first_name}  <i>(${video.user.user_name})</i></h4>
					</div>
					<div class="col-md-3 text-right"  style="display: ${video.user.id == user.id ? 'none' : 'block'}">
						<button class="btn btn-success btn-subscribe subscribe" style="background: rgb(255, 153, 153); border: none;" data-toUserId="${video.user.id}">SUBSCRIBE</button>
					</div>
				</div>
				<hr>
				<div>
					<h4>
						<i>Comments</i>
					</h4>
					<form:form action="./user/view-video/${video.id}.htm" modelAttribute="comment">
						<form:textarea path="comment" id="message" placeholder="Enter Your Comment" rows="2" cols="30"
							class="form-control"/>
						
						<div class="mt-2 text-right">
							<button type="submit" class="btn btn-secondary cmtButton">Comment</button>
						</div>
					</form:form>
					<hr>
					<c:forEach var="c" items="${comments}">
						<div>
							<h5 style="float: ${c.user.id == user.id ? 'left' : 'none'}">${c.user.first_name} ${c.user.last_name} </h5>

							<c:if test="${c.user.id == user.id}">
								<p style="float: ${c.user.id == user.id ? 'right' : 'none'}"><a style="cursor: pointer; color: black" href="user/delete-comment/${c.id}.htm" data-cmtID="${c.id}" class="deleteBtn"><i  class="fas fa-times "></i></a></p>
								<div style="clear:both"></div>
							</c:if>
						
							<i>(${c.user.user_name})</i>
							<p>${c.comment}</p>
						</div>
						<hr>
					</c:forEach>
				</div>
				<hr>

			</div>
			<div class="col-md-5" style="">
				<c:forEach var="v" items="${videos}">
					<c:if test="${v.id != video.id}">
								<div class="row mb-3" style="cursor: pointer; background-color: #F9F9F9"
						onclick="location.href='./user/view-video/${v.id}.htm'">
						<div class="col-md-5">
							<img src="${v.image_url}" class="card-img-top" alt="url_image" style="width: 100%" />
						</div>
						<div class="col-md-7 pl-0 pt-2">
							<p class="video-text" style="font-weight: bold">${v.title}</p>
							<p class="video-text">${v.description}</p>
							<p class="video-text">Duration: ${v.duration}</p>
							<p class="video-text">${v.views} ${v.views > 1 ? 'views' : 'view'}</p>

						</div>
					</div>
					</c:if>
				</c:forEach>
			</div>

		</div>
	</div>
	
	 <jsp:include page="./../include/footer.jsp">
	 	<jsp:param value="${user.role}" name="userRole"/>
	 </jsp:include>

</body>

<c:if test="${liked == true}">
	<script>
		$(".like-btn").css('color', '#FF9999');
	</script>
</c:if>
<c:if test="${disliked == true}">
	<script>
		$(".dislike-btn").css('color', '#FF9999');
	</script>
</c:if>
<script>
		
		$(".subscribe").css('background', '#6c757d');
</script>
<c:if test="${isSub == 'yes'}">
	<script>
		$(".subscribe").text("SUBSCRIBED");
		$(".subscribe").css('background', '#6c757d');
	</script>
</c:if>
<c:if test="${isSub == 'no'}">
	<script>
		$(".subscribe").text("SUBSCRIBE");
		$(".subscribe").css('background', '#FF9999');
	</script>
</c:if>
<script>

	$(document).ready(function () {

		$(".like-btn").click(function () {
			var xhr = new XMLHttpRequest();
			$.get("./user/like-video/" + $(this).attr("data-videoID") + ".htm", function (data, status) {
				console.log(typeof data);
				console.log(data);
				var data = data.split("-");
				var totalLike = data[0];
				var totalDislike = data[1];

				console.log(data[0]);
				console.log(data[1]);

				var oldTotal = parseInt($(".video-like").text());
				var newTotal = parseInt(totalLike);
				if (oldTotal < newTotal) {
					$(".like-btn").css('color', '#FF9999');
					$(".dislike-btn").css('color', '#909090');
				}
				else {
					$(".like-btn").css('color', '#909090');
				}
				$(".video-like").text(totalLike);
				$(".video-dislike").text(totalDislike);
			});
		});
	})

	$(document).ready(function () {

		$(".dislike-btn").click(function () {
			var xhr = new XMLHttpRequest();
			$.get("./user/dislike-video/" + $(this).attr("data-videoID") + ".htm", function (data, status) {
				var data = data.split("-");
				var totalLike = data[0];
				var totalDislike = data[1];
				console.log(data[0]);
				console.log(data[1]);
				var oldTotal = parseInt($(".video-dislike").text());
				var newTotal = parseInt(totalDislike);
				if (oldTotal < newTotal) {
					$(".dislike-btn").css('color', '#FF9999');
					$(".like-btn").css('color', '#909090');
				}
				else {
					$(".dislike-btn").css('color', '#909090');

				}
				$(".video-like").text(totalLike);
				$(".video-dislike").text(totalDislike);
			});
		});
	})
	
	$(document).ready(function () {

		$(".btn-subscribe").click(function () {
			var xhr = new XMLHttpRequest();
			console.log($(this).attr("data-toUserId"));
			$.get("./user/subscribe/" + $(this).attr("data-toUserId") + ".htm", function (data, status) {
				console.log(data);

				$(".subscribe").text(data);
				if(data === "SUBSCRIBED") {
					$(".subscribe").css('background', '#6c757d');
				}else {
					$(".subscribe").css('background', '#FF9999');
				}
			}); 
		});
	})
</script>
<script>
$(document).ready(function(){
    $('.cmtButton').attr('disabled',true);
    $('#message').keyup(function(){
    	var comment = $.trim($(this).val());
    	console.log(comment);
        if(comment.length !=0)
            $('.cmtButton').attr('disabled', false);            
        else
            $('.cmtButton').attr('disabled',true);
    })
});
</script>
<script>
	$(function() {
		$(document).ready(function() {
			$(".deleteBtn").click(function(){
			    if (!confirm("Are you sure?")){
			      return false;
			    }
			 });
		})
	})
</script>

</html>