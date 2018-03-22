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
						<ul class="am-icon-flag on">订单详情列表
						</ul>
					</div>
					<form class="am-form am-g">
						<table width="100%"
							class="am-table am-table-bordered am-table-radius am-table-striped am-table-hover">
							<thead>
								<tr class="am-success">
									<th class="table-title">ID</th>
									<th class="table-title">订单号</th>
									<th class="table-title">收货人</th>
									<th class="table-title">商品名</th>
									<th class="table-type">数量</th>
									<th class="table-date am-hide-sm-only">备注</th>
									<th class="table-title">总价</th>
									<th width="130px" class="table-set">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${order.orderdetails }" var="o">
									<tr>
										<td>${o.id }</td>
										<td>${order.id }</td>
										<td>${order.name }</td>
										<td>${o.food.name }</td>
										<td>${o.count }</td>
										<td>${o.text}</td>
										<td>${o.sum }</td>									
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<button type="button" title="修改此条记录" data-am-modal="{target: '#my-popups'}" 
														class="am-btn am-btn-default am-btn-xs am-text-secondary am-round" 
														onclick="window.location.href('${basePath}/order/getOrderDetailById.action?oid=${order.id }&id=${o.id }')">
														<span class="am-icon-pencil-square-o"></span>
													</button>
													<button type="button"
														class="am-btn am-btn-default am-btn-xs am-text-danger am-round" title="删除此条订单详情"
														onclick="window.location.href('${basePath}/order/deleteOrderDetail.action?oid=${order.id }&id=${o.id }')">
														<span class="am-icon-trash-o"></span>
													</button>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="am-btn-group am-btn-group-xs">
							<button type="button" class="am-btn am-btn-default" onclick="window.location.href('${basePath}/order/addOrderDetailPage.action?id=${order.id }')">
								<span class="am-icon-plus"></span> 新增
							</button>
						</div>
						<hr />
						<p>注：.....</p>
					</form>

				</div>
				<%@ include file="/admin/footer_index.jsp"%>
			</div>

		</div>
	</div>
</body>
</html>
</html>