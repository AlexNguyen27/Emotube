<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function delayer(delay) {
		onLoad = setTimeout(
				'window.location.href = "${pageContext.servletContext.contextPath}/sign-in.htm"',
				delay);
	}
</script>
<body>
	<script>
		delayer(1000)
	</script>
</body>
</html>