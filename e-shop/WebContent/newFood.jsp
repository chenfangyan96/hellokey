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
			<div class="specials">
			<h2>最新商品</h2>
				<div class="special-top" style="height:400px;">		
					<c:forEach items="${subList }" var="food">			
						<div class="col-md-3 special-in">
							<a href="${basePath }/food/getFood.action?id=${food.id}"><img
									src="${basePath }/${food.imgurl }" class="img-responsive" style="width:186px;height:190.8px;"></a>
							
							<h5><a href="${basePath }/food/getFood.action?id=${food.id}">${food.name }</a></h5>
							<p>$${food.price }</p>
							
						</div>
					</c:forEach>
					<div class="clearfix"> </div>
				</div>
					<c:if test="${page != null && page.page_count > 1 }">
						<div class="browse">
							<a class="more" style="width: 300px; height: 51px;"
								href="${basePath }/food/getHotFoods.action?state=${state }&current_page=1">首页</a>
							<a class="more" style="width: 520px; height: 51px;"> <c:if
									test="${page.current_page != 1 }">上一页</c:if> <c:if
									test="${page.current_page != page.page_count }">下一页</c:if>
							</a>
							<c:if test="${page.current_page != 1 }">
								<a class="wmuSliderNext" style="bottom: 33px; left: 345px;"
									href="${basePath }/food/getHotFoods.action?state=${state }&current_page=${page.current_page - 1 }"></a>
							</c:if>
							<c:if test="${page.current_page != page.page_count }">
								<a class="wmuSliderPrev" style="bottom: 33px; left: 750px;"
									href="${basePath }/food/getHotFoods.action?state=${state }&current_page=${page.current_page + 1 }"></a>
							</c:if>

							<a class="more" style="width: 300px; height: 51px;"
								href="${basePath }/food/getHotFoods.action?state=${state }&current_page=${page.page_count }">尾页</a>
							<div class="clearfix"></div>
						</div>
					</c:if>
			</div>
		</div>

	<!---->
	<!--footer-->
	<jsp:include page="/footer.jsp" />
	<!---->
</body>
</html>