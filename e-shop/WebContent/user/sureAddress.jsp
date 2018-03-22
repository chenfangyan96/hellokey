<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/path.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Home</title>
<link href="${basePath }/css/bootstrap.css" rel="stylesheet"
	type="text/css" media="all" />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${basePath }/js/jquery.min.js"></script>
<!-- Custom Theme files -->
<!--theme-style-->
<link href="${basePath }/css/style.css" rel="stylesheet" type="text/css"
	media="all" />
<!--//theme-style-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Food shop Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript">
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 

</script>

<script type="text/javascript" src="${basePath }/js/move-top.js"></script>
<script type="text/javascript" src="${basePath }/js/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
		});
	});
</script>

</head>
<body>
	<!--header-->

	<jsp:include page="/header.jsp" />
	<!---->
	<!--container-->
	<div class="container">
		<div class="contact">
			<div class="contact-in">
				<h2>确认收货地址</h2>
				<div class=" col-md-9 contact-left">

					<div>
						<span>收货人： ${address.name }</span>
					</div>
					<div>
						<span>联系方式： ${address.telephone }</span>
					</div>
					<div>
						<span>省市区： ${address.area }</span>
					</div>
					<div>
						<span>街道： ${address.street }</span>
					</div>
					<div>
						<span>详细信息： ${address.fulladdress }</span>
					</div>
					<div>
						<h4 class="title" style="position: relative;">
							<a href="${basePath }/user/getAddresses.action">修改收货地址</a> 
							<a href="${basePath }/order/commitOrder.action">确认该地址 </a>
						</h4>
					</div>
				</div>

				<div class="clearfix"></div>
			</div>

		</div>
	</div>


	<!---->
	<!--footer-->
	<jsp:include page="/footer.jsp" />
	<!---->
</body>
</html>