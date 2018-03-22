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
						<ul class="am-icon-flag on">修改订单
						</ul>
					</div>

					<div class="fbneirong">
						<form class="am-form" action="${basePath}/order/updateOrder.action">
							<div class="am-form-group am-cf">
								<div class="zuo">订单ID：</div>
								<div class="you">${order.id }</div>
								<input type="hidden"name="id" value="${order.id }">
							</div>
							<div class="am-form-group am-cf" style="height: 20px;"></div>

							<div class="am-form-group am-cf">
								<div class="zuo">下单时间：</div>
								<div class="you">${order.time }</div>
							</div>
							<div class="am-form-group am-cf" style="height: 20px;"></div>

							<div class="am-form-group am-cf">
								<div class="zuo">订单状态：</div>
								<div class="you">
									<c:if test="${order.state=='nopay' }">
												等待用户支付
											</c:if>
									<c:if test="${order.state =='pay' }">
												待发货
												<button type="button" class="am-btn am-btn-default"
													onclick="window.location.href('${basePath }/order/updateOrderState.action?id=${order.id}&action=back&state=${order.state}')">
													<span class="am-icon-plus"></span> 发货
												</button>
									</c:if>
									<c:if test="${order.state == 'sending' }">
												商品运送中
												<button type="button" class="am-btn am-btn-default"
													onclick="window.location.href('${basePath }/order/updateOrderState.action?id=${order.id}&action=back&state=${order.state}')">
													<span class="am-icon-plus"></span> 送达
												</button>
											</c:if>
									<c:if test="${order.state == 'senddone' }">
												待收货
											</c:if>
									<c:if test="${order.state == 'done' }">
												此单已完成
											</c:if>
									<c:if test="${order.state == 'norepay' }">
												待退款
												<button type="button" class="am-btn am-btn-default"
													onclick="window.location.href('${basePath }/order/updateOrderState.action?id=${order.id}&action=back&state=${order.state}')">
													<span class="am-icon-plus"></span> 退款
												</button>
											</c:if>
									<c:if test="${order.state == 'fail' }">
												已取消的订单
											</c:if>
								</div>
							</div>
							<div class="am-form-group am-cf" style="height: 20px;"></div>

							<div class="am-form-group am-cf">
								<div class="zuo">收货人：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										name="name" value="${order.name }">
								</div>
							</div>
							<div class="am-form-group am-cf" style="height: 20px;"></div>
							<div class="am-form-group am-cf">
								<div class="zuo">联系方式：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										name="telephone" value="${order.telephone }">
								</div>
							</div>

							<div class="am-form-group am-cf" style="height: 20px;"></div>
							<div class="am-form-group am-cf">
								<div class="zuo">收货省市县：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										name="area" value="${order.area }">
								</div>
							</div>

							<div class="am-form-group am-cf" style="height: 20px;"></div>
							<div class="am-form-group am-cf">
								<div class="zuo">街道：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										name="street" value="${order.street }">
								</div>
							</div>

							<div class="am-form-group am-cf" style="height: 20px;"></div>
							<div class="am-form-group am-cf">
								<div class="zuo">详细地址：</div>
								<div class="you">
									<input type="text" class="am-input-sm" id="doc-ipt-pwd-1"
										name="fulladdress" value="${order.fulladdress }">
								</div>
							</div>


							<div class="am-form-group am-cf" style="height: 20px;"></div>

							<div class="am-form-group am-cf">
								<div class="you" style="margin-left: 11%;">
									<button type="submit" class="am-btn am-btn-success am-radius">修改</button>
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
</html>