<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/path.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>A Book Apart后台管理系统</title>
<meta name="description" content="这是一个 index 页面">
<meta name="keywords" content="index">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="${path2 }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed"
	href="${path2 }/assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="${path2 }/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="${path2 }/assets/css/admin.css">
<script src="${path2 }/assets/js/jquery.min.js"></script>
<script src="${path2 }/assets/js/app.js"></script>
<style type="text/css">
#table-0 {
	align: center;
	margin-left: 260px;
}

#last {
	position: fixed;
	bottom: 0;
}
</style>
</head>
<body>
	<%@ include file="/admin/top_index.jsp"%>
	<div class="am-cf admin-main">
		<%@ include file="/admin/left_index.jsp"%>
		<div class=" admin-content">
			<div class="daohang"></div>
			<div class="admin">
				<div class="admin-biaogelist">

					<div class="listbiaoti am-cf">
						<ul class="am-icon-flag on">新增订单详情
						</ul> 
					</div>

					<div class="fbneirong">
						<form class="am-form" action="${basePath}/order/addOrderDetail.action" >
							<input type="hidden" name="oid" value="${id }">
							<div class="am-form-group am-cf">
								<div class="zuo">商品名：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-email-1"
										placeholder="请输入已有的商品名" name="name">
								</div>
							</div>
							<div class="am-form-group am-cf" style="height:20px;">
							</div>
							<div class="am-form-group am-cf">
								<div class="zuo">商品数量：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										placeholder="请填写整数" name="count">
								</div>
							</div>
							<div class="am-form-group am-cf" style="height:20px;">
							</div>
							<div class="am-form-group am-cf">
								<div class="zuo">备注：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										placeholder="为此订单详情增添备注" name="text">
								</div>
							</div>
							
							<div class="am-form-group am-cf" style="height:20px;">
							</div>
							
							<div class="am-form-group am-cf">
								<div class="you" style="margin-left: 11%;">
									<button type="submit" class="am-btn am-btn-success am-radius" >新增</button>
								</div>
							</div>
						</form>
					</div>




				</div>
				<%@ include file="/admin/footer_index.jsp"%>
			</div>

		</div>
	</div>
</body>
${msg }
</html>