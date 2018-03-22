package com.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.common.Page;
import com.entity.CartBean;
import com.entity.Food;
import com.entity.Food_Cart;
import com.entity.Type;
import com.entity.User;
import com.service.FoodService;

@Controller
@RequestMapping("/food")
public class FoodAction {
	@Autowired
	private FoodService foodService;

	//分页展示商品
	@RequestMapping("/getFoods")
	public String getFoods(Model model, HttpServletRequest request) {
		String columnpage = request.getParameter("columnpage");
		String typeid = request.getParameter("typeid");
		String current_page = request.getParameter("current_page");		
		Page page = foodService.getPage(current_page, typeid,columnpage);
		List<Food> subList = foodService.getSomeFood(page, typeid,columnpage);
		model.addAttribute("page", page);		
		model.addAttribute("subList", subList);
		model.addAttribute("typeid", typeid);
		//每页12条记录跳转到后台展示
		if("12".equals(columnpage)) {
			//获得该页商品类型
			Type type = foodService.getTypeById(typeid);
			model.addAttribute("type", type);
			List<Type>typeList = foodService.getAllType(); 
			model.addAttribute("typeList", typeList);
			return "admin/showFoods";
		}
		return "index";

	}

	//分页展示热门商品
	@RequestMapping("/getHotFoods")
	public String getHotFoods(Model model, HttpServletRequest request) {
		String current_page = request.getParameter("current_page");	
		String state = request.getParameter("state");
		//获得page
		Page page = foodService.getPageByState(current_page,state);
		//获得部分商品
		List<Food> subList = foodService.getSomeFoodByState(page, state);
		
		model.addAttribute("state", state);
		model.addAttribute("page", page);		
		model.addAttribute("subList", subList);
		if("hot".equals(state)) {
			
			return "hotFood";
		}
		return "newFood";

	}
	//后台删除商品
	@RequestMapping("/deleteFood")
	public String deleteFood(HttpServletRequest request,Model model) {
		String current_page = request.getParameter("current_page"); 
		String id = request.getParameter("id");
		Food food = foodService.getFoodById(id);
		if(food.getSale().equals("1")) {
			model.addAttribute("msg", "请先下架此商品");
			return "admin/erreo";
		}
		try {
			foodService.deleteFood(id);
			return "redirect:/food/getFoods.action?typeid=0&columnpage=12&current_page="+current_page;
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "所选商品已被用户下单或存在于用户购物车中，不可删除");
			return "admin/erreo";
		}		
	}
	
	//后台批量删除商品
	@RequestMapping("/deleteFoods")
	public String deleteFoods(HttpServletRequest request,Model model) {
		String current_page = request.getParameter("current_page");
		String[] arr = request.getParameterValues("choose");
		if(arr == null) {
			return "redirect:/food/getFoods.action?typeid=0&columnpage=12&current_page="+current_page;
		}
		for(int i=0;i<arr.length;i++) {
			Food food = foodService.getFoodById(arr[i]);
			if(food.getSale().equals("1")) {
				model.addAttribute("msg", "请先下架所有商品");
				return "admin/erreo";
			}
		}
		try {
			foodService.deleteFoods(arr);
			return "redirect:/food/getFoods.action?typeid=0&columnpage=12&current_page="+current_page;
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "所选商品已被用户下单或存在于用户购物车中，不可删除");
			return "admin/erreo";
		}		
	}
	
	//查看商品详情
	@RequestMapping("/getFood")
	public String getFood(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String current_page = request.getParameter("current_page");
		String id = request.getParameter("id");
		String action = request.getParameter("action");
		Food food = foodService.getFoodById(id);		
		model.addAttribute("food", food);
		//参数为1跳转到后台展示单个商品页面
		if("1".equals(action)) {
			model.addAttribute("current_page", current_page);
			return "admin/showFood";
		}
		//参数为2跳转到后台修改单个商品页面
		if("2".equals(action)) {
			return "admin/updateFood";
		}
		//为空跳转到前台展示单个商品页面
		if(food.getSale().equals("0")) {
			User u = (User) session.getAttribute("U");
			if(u!=null){
				foodService.deleteFoodCart(id,u);	
				model.addAttribute("msg", "此商品已经下架");
				model.addAttribute("url", "food/showMyCart.action");
			}
			model.addAttribute("msg", "此商品已经下架");
			model.addAttribute("url", "food/getFoods.action?typeid=0&columnpage=6");
			return "erreo2";
		}
		return "single";

	}
	
	//加入购物车
	@RequestMapping("/addMyCart")
	public String addMyCart(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("U");
		//获得我的购物车
		CartBean cartbean = foodService.getMyCart(user);
		String foodid = request.getParameter("id");
		String text = request.getParameter("text");
		String count = request.getParameter("count");
		//先购物车中添加数据
		CartBean cart = foodService.addIntoCart(foodid,cartbean,text,count);	
		if(cart == null) {
			return"erreo2";
		}
		return "redirect:/food/showMyCart.action";

	}
	
	//分页显示我的购物车
	@RequestMapping("/showMyCart")
	public String showMyCart(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		String current_page = request.getParameter("current_page");
		User user = (User) session.getAttribute("U");
		//根据用户查询购物车
		CartBean cartbean = foodService.getMyCart(user);
		//获得一个page
		Page page = foodService.getCartPage(current_page,cartbean);
		//为购物车添加商品信息
		CartBean cart = foodService.addFoodCartByPage(cartbean,page);	
		System.out.println("查询购物车"+cart);
		if(cart.isEmpty()) {
			cart=null;
		}
		model.addAttribute("cart", cart);
		model.addAttribute("page", page);
		return "user/myCart";		
	}
	
	//批量删除购物车商品信息
	 	@RequestMapping("/deleteSomeFoodCart")
	 	public String deleteSomeFoodCart(HttpServletRequest request,Model model) {
	 		String current_page = request.getParameter("current_page");
	 		String[] arr = request.getParameterValues("choose");
	 		if(arr == null) {
	 			return "redirect:/food/showMyCart.action?current_page="+current_page;
	 		}
	 		foodService.deleteSomeFoodCart(arr);		
	 		return "redirect:/food/showMyCart.action?current_page="+current_page;
	 		
	 	}
	//清空购物车
	@RequestMapping("/emptyCart")
	public String emptyCart(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("U");
		boolean result = foodService.emptyCart(user); 
		if(result==true) {
			return "redirect:/food/showMyCart.action";
		}
		model.addAttribute("msg", "清空购物车失败");
		model.addAttribute("url", "food/showMyCart.action");
		return "erreo2";		
	}
     
	//删除购物车中的商品
     @RequestMapping("/deleteFoodCart")
 	public String deleteFoodCart(HttpServletRequest request,Model model) {
    	 String current_page = request.getParameter("current_page");
    	String foodid = request.getParameter("id");
 		boolean result = foodService.deleteFoodCart(Integer.parseInt(foodid)); 
 		if(result==true) {
 			return "redirect:/food/showMyCart.action?current_page=" + current_page;
 		}
 		model.addAttribute("msg", "删除失败");
 		model.addAttribute("url", "food/showMyCart.action");
 		return "erreo2";		
 	}
     
     //-购物车中商品数量减1
     @RequestMapping("/cutFoodCount")
  	public String cutFoodCount(HttpServletRequest request,Model model) {
     	String foodid = request.getParameter("id");
  		boolean result = foodService.cutFoodCount(Integer.parseInt(foodid)); 
  		if(result==true) {
  			return "redirect:/food/showMyCart.action";
  		}else {
  			model.addAttribute("msg", "修改数量失败");
  	  		model.addAttribute("url", "food/showMyCart.action");
  	  		return "erreo2";	
  		}
  			
  	}
 
     //根据名字搜索商品
     @RequestMapping("/getFoodByName")
  	public String getFoodByName(HttpServletRequest request,Model model) {
     	String name = request.getParameter("name");
     	Food food = foodService.getFoodByName(name);
  		if(food==null) {
  			model.addAttribute("msg", "商品不存在!");
			return "admin/erreo";
  		}
  		model.addAttribute("food", food);
  		return "redirect:/food/getFood.action?action=1&id="+food.getId();		
  	}  
     
   //+购物车中商品数量加1
     @RequestMapping("/addFoodCount")
  	public String addFoodCount(HttpServletRequest request,Model model) {
     	String foodid = request.getParameter("id");
  		boolean result = foodService.addFoodCount(Integer.parseInt(foodid)); 
  		if(result==true) {
  			return "redirect:/food/showMyCart.action";
  		}
  		model.addAttribute("msg", "修改数量失败");
  		model.addAttribute("url", "food/showMyCart.action");
  		return "erreo2";		
  	}
     
     //后台新增商品
     @RequestMapping("/addFood")
   	public String addFood(HttpServletRequest request,Food food,@RequestParam MultipartFile imagefile,Model model) throws IOException {
    	// 获得图片上传的路径
 		String realPath = request.getServletContext().getRealPath("/images");
 		//根据商品类型名获得商品类型
 		String typename = request.getParameter("typename");
 		Type type  = foodService.getTypeByName(typename);
 		System.out.println("商品类型"+type);
 		if(type==null) {
 			model.addAttribute("msg", "<script>alert(\"请输入已存在的商品类型名称!\")</script>");
 			return "admin/addFood";
 		}else {
 			//添加商品
 	 		boolean result = foodService.addFood(food,realPath,imagefile,type);
 	 		if(result==true) {
 	 			return "redirect:/food/getFoods.action?typeid=0&columnpage=12";
 	 		}
 	 		model.addAttribute("msg", "添加商品失败");
 	  		return "admin/erreo";
 		}
 		
      	
   	}
     
     //后台新增商品类别
     @RequestMapping("/addFoodType")
   	public String addFoodType(HttpServletRequest request,Model model){
 		//根据商品类型名获得商品类型
 		String name = request.getParameter("name");
 		Type type  = foodService.getTypeByName(name);
 		System.out.println("商品类型"+type);
 		if(type!=null) {
 			model.addAttribute("msg", "<script>alert(\"此商品类别已存在!\")</script>");
 			return "admin/addFoodType";
 		}else {
 			//添加商品类别
 	 		boolean result = foodService.addFoodType(name);
 	 		if(result==true) {
 	 			return "redirect:/food/getFoods.action?typeid=0&columnpage=12";
 	 		}
 	 		model.addAttribute("msg", "添加商品类别失败");
 	  		return "admin/erreo";
 		}
 		
      	
   	}
   //后台修改商品
     @RequestMapping("/updateFood")
   	public String updateFood(HttpServletRequest request,Food food,@RequestParam MultipartFile imagefile,Model model) throws IOException {
    	// 获得图片上传的路径
 		String realPath = request.getServletContext().getRealPath("/images");
 		//根据商品类型名获得商品类型
 		String typename = request.getParameter("typename");
 		Type type  = foodService.getTypeByName(typename);
 		System.out.println("商品类型"+type);
 		if(type==null) {
 			model.addAttribute("msg", "<script>alert(\"请输入已存在的商品类型名称!\")</script>");
 			return "admin/addFood";
 		}
 		//修改商品
 		boolean result = foodService.updateFood(food,realPath,imagefile,type);
 		if(result==true) {
 			return "redirect:/food/getFoods.action?typeid=0&columnpage=12";
 		}
 		model.addAttribute("msg", "添加商品失败");
  		return "admin/erreo";
      	
   	}
    
     //更新商品状态
     @RequestMapping("/updateFoodState")
  	public String updateFoodState(HttpServletRequest request,Model model) {
    	String id = request.getParameter("id");
 		String state = request.getParameter("state");
 		System.out.println("11111111111111111111111111111" + state);
 		// 更新用户状态
 		boolean result = foodService.updateFoodState(id, state);
 		if (result == true) {
 			return "redirect:/food/getFoods.action?typeid=0&columnpage=12";
 		}
 		model.addAttribute("msg", "操作失败，请重试！");
 		return "erreo";	
  	}   
     
     //更改商品上下架
     @RequestMapping("/updateFoodSale")
   	public String updateFoodSale(HttpServletRequest request,Model model) {
     	String id = request.getParameter("id");
     	String current_page = request.getParameter("current_page");
  		String sale = request.getParameter("sale");
  		System.out.println("11111111111111111111111111111" + sale);
  		// 更新用户状态
  		boolean result = foodService.updateFoodSale(id, sale);
  		if (result == true) {
  			return "redirect:/food/getFoods.action?typeid=0&columnpage=12&current_page="+current_page;
  		}
  		model.addAttribute("msg", "操作失败，请重试！");
  		return "erreo";	
   	}   
}


















