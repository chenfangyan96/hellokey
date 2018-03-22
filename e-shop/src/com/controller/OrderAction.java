package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.Page;
import com.entity.Address;
import com.entity.CartBean;
import com.entity.Food;
import com.entity.Order;
import com.entity.OrderDetail;
import com.entity.User;
import com.service.FoodService;
import com.service.OrderService;
import com.service.UserService;

@Controller
@RequestMapping("/order")
public class OrderAction {
	@Autowired
	private OrderService orderService;
	@Autowired
	private FoodService foodService;
	@Autowired
	private UserService userService;
		
	//检测地址
	@RequestMapping("/checkAddress")
	public String checkAddress(Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("U");
		//根据user获得当前收货地址
		Address address = userService.getCurrentAddress(user);
		if(address==null) {
			model.addAttribute("msg", "您的当前地址没有设定，请前去设定");
			model.addAttribute("url", "user/getAddresses.action");
			return "erreo2";
		}else {
			model.addAttribute("address", address);
			return "user/sureAddress";
		}
	}
	
	//生成订单
	@RequestMapping("/commitOrder")
	public String commitOrder(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("U");
		//获得当前购物车
		CartBean cartbean = foodService.getMyCart(user);
		//获取购物车商品信息
		CartBean cart = foodService.addFoodCart(cartbean);
		//根据user获得当前收货地址
		Address address = userService.getCurrentAddress(user);
		if(cart.isEmpty()||cart == null) {
			model.addAttribute("msg", "购物车为空，请返回");
			model.addAttribute("url", "user/myCart.jsp");
			return "erreo2";
		}
		//提交订单并且清空购物车
		Order order = orderService.commitOrder(cart,user,address);
		if(order!=null) {
			model.addAttribute("order", order);	
			List<OrderDetail>detailLsit = orderService.getOrderDetails(order.getId());						
			model.addAttribute("detailLsit", detailLsit);
			return "user/showOrder";
		}		
		model.addAttribute("msg", "订单生成失败，请重新生成");
		model.addAttribute("url", "food/showMyCart.action");
		return "erreo2";
		
	}
	
	//根据用户获得所有订单
	@RequestMapping("/getOrders")
	public String getOrders(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		User u = new User();
		if("back".equals(action)) {
			User user = new User();
			String id = request.getParameter("id");
			user.setId(Integer.parseInt(id));
			u =  userService.getUser(user);
		}else {
			u=(User) session.getAttribute("U");	
		}			
		List<Order>orders= orderService.getOrders(u);
		model.addAttribute("orders", orders);	
		if("back".equals(action)) {
			return"admin/showUserOrder";
		}
		return "user/myOrders";
		
	}
	
	//（根据订单id获得该订单所有订单详情）查询订单
	@RequestMapping("/getOrderDetail")
	public String getOrderDetail(HttpServletRequest request,Model model) {
		String id = request.getParameter("id");
		String action = request.getParameter("action");
		Order order  = orderService.getOrder(Integer.parseInt(id));
//		List<OrderDetail>detailLsit = orderService.getOrderDetails(Integer.parseInt(id));
		model.addAttribute("order", order);
//		model.addAttribute("detailLsit", detailLsit);
		if("back".equals(action)) {
			return "admin/showOrder";
		}
		return "user/showOrder";
		
	}
	
	//根据订单状态分页获取订单
	@RequestMapping("/showOrders")
	public String showOrders(HttpServletRequest request,Model model) {
		String state = request.getParameter("action");
		String current_page = request.getParameter("current_page");	
		Page page = orderService.getPage(current_page,state);
		List<Order>orders = orderService.getOrderByStates(state,page);
		model.addAttribute("page", page);
		model.addAttribute("orders", orders);
		model.addAttribute("action", state);
		return "admin/showOrders";
		
	}
		
	//修改订单的状态信息
		@RequestMapping("/updateOrderState")
		public String updateOrderState(HttpServletRequest request,Model model) {
			String oid = request.getParameter("id");
			String state = request.getParameter("state");
			String action = request.getParameter("action");
			System.out.println("订单号"+oid);
			System.out.println("订单状态"+state);
			System.out.println("操作"+action);
			boolean result = orderService.updateOrderState(oid,state,action);
			if(result == true) {
				if("back".equals(action)) {
					System.out.println("backbackback.........");
					return "redirect:/order/getOrder.action?id="+oid;
				}
				Order order = orderService.getOrder(Integer.parseInt(oid));
				model.addAttribute("order", order);
				return "redirect:/order/getOrderDetail.action?id="+oid;
			}
			model.addAttribute("msg", "操作失败，请重新尝试");
			model.addAttribute("url", "order/getOrderDetail.action?id="+oid);
			return "erreo2";
			
		}
		
		//为订单增加订单详情
			@RequestMapping("/addOrderDetail")
			public String addOrderDetail(HttpServletRequest request,Model model,OrderDetail od) {
				String oid = request.getParameter("oid");
				System.out.println("订单号"+oid);
				String name = request.getParameter("name");
				System.out.println("商品名"+name);
				Food food = foodService.getFoodByName(name);
				System.out.println("商品"+food);				
				if(food == null) {
		 			return "redirect:/order/addOrderDetailPage.action?id="+oid+"&msg=1";
				}
				boolean res = orderService.isHasFood(food,oid);
				if(res==true) {
					return "redirect:/order/addOrderDetailPage.action?id="+oid+"&msg=2";
				}
				boolean result = orderService.addOrderDetail(food,oid,od);			
				if(result == true) {
					return "redirect:/order/getOrderDetail.action?id="+oid+"&action=back";
				}
				model.addAttribute("msg", "操作失败，请重新尝试");
				return "admin/erreo";
				
			}
			
			//页面跳转传参
			@RequestMapping("/addOrderDetailPage")
			public String addOrderDetailPage(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				String msg = request.getParameter("msg");
				if("1".equals(msg)) {
					model.addAttribute("msg", "<script>alert(\"请输入已存在的商品名称!\")</script>");
				}	
				if("2".equals(msg)) {
					model.addAttribute("msg", "<script>alert(\"该商品此订单已存在，请前去修改!\")</script>");
				}	
				model.addAttribute("id", id);
				return "admin/addOrderDetail";
				
			}
			
			//为订单删除订单详情
			@RequestMapping("/deleteOrderDetail")
			public String deleteOrderDetail(HttpServletRequest request,Model model) {
				String oid = request.getParameter("oid");
				String id = request.getParameter("id");
				boolean result = orderService.deleteOrderDetail(oid,id);
				if(result == true) {
					return "redirect:/order/getOrderDetail.action?id="+oid+"&action=back";
				}
				model.addAttribute("msg", "操作失败，请重新尝试");
				return "admin/erreo";
				
			}					

			
			//获取订单详情
			@RequestMapping("/getOrderDetailById")
			public String getOrderDetailById(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				String oid = request.getParameter("oid");
				OrderDetail od = orderService.getOrderDetail(id);
				model.addAttribute("od", od);
				model.addAttribute("oid", oid);
				return "admin/updateOrderDetail";
				
			}	
			
			//为订单更新订单详情
			@RequestMapping("/updateOrderDetail")
			public String updateOrderDetail(HttpServletRequest request,Model model,OrderDetail od) {
				String id = request.getParameter("id");
				String oid = request.getParameter("oid");
				boolean result = orderService.updateOrderDetail(id,od);
				if(result == true) {
					return "redirect:/order/getOrderDetail.action?id="+oid+"&action=back";
				}
				model.addAttribute("msg", "操作失败，请重新尝试");
				return "admin/erreo";
				
			}	
			
			//获得订单展示在后台更新订单页面
			@RequestMapping("/getOrder")
			public String getOrder(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				Order order  = orderService.getOrder(Integer.parseInt(id));
				model.addAttribute("order", order);
				return "admin/updateOrder";
				
			}
			
			//更新订单
			@RequestMapping("/updateOrder")
			public String updateOrder(HttpServletRequest request,Model model,Order o) {
				boolean result = orderService.updateOrder(o);
				if(result == true) {
					return "redirect:/order/getOrder.action?id="+o.getId();
				}
				model.addAttribute("msg", "更新失败，请重新尝试");
				return "admin/erreo";
				
			}
			
			//删除订单
			@RequestMapping("/deleteOrder")
			public String deleteOrder(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				String current_page=request.getParameter("current_page");
				String action=request.getParameter("action");
				boolean result = orderService.deleteOrder(id);
				if("back".equals(action)) {
					model.addAttribute("msg", "删除成功！");
					return "admin/erreo";
				}
				if(result == true) {
					return "redirect:/order/showOrders.action?action="+action+"&current_page="+current_page;
				}
				model.addAttribute("msg", "删除失败，请重新尝试");
				return "admin/erreo";
				
			}
			
			//根据商品id查询订单
			@RequestMapping("/getOrdersByFood")
			public String getOrdersByFood(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				List<OrderDetail>oo = orderService.getOrderDetailsByFood(id);
				if(oo.isEmpty()) {
					model.addAttribute("msg", "没有任何订单！");
					return "admin/erreo";
				}
				List<Order>orders = new ArrayList<Order>();
				for(OrderDetail o:oo) {
					orders.add(o.getOrder());
				}
				model.addAttribute("orders", orders);
				return "admin/showUserOrder";
			}
			
			//根据订单id查询订单
			@RequestMapping("/getOrderById")
			public String getOrderById(HttpServletRequest request,Model model) {
				String id = request.getParameter("id");
				Order order = orderService.getOrderById(id);
				if(order == null) {
					model.addAttribute("msg", "没有此订单！");
					return "admin/erreo";
				}
				List<Order>orders = new ArrayList<Order>();
				orders.add(order);
				model.addAttribute("orders", orders);
				return "admin/showUserOrder";
			}
}
