package com.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.common.Page;
import com.dao.FoodDao;
import com.entity.CartBean;
import com.entity.Food;
import com.entity.Food_Cart;
import com.entity.Type;
import com.entity.User;

@Service
@Transactional
public class FoodService {
	@Autowired
	private FoodDao foodDao;

	// 根据分页和类型获得部分商品列表
	public List<Food> getSomeFood(Page page, String typeid, String columnpage) {
		// TODO Auto-generated method stub
		List<Food> subList = new ArrayList<Food>();
		if (typeid.equals("0")) {
			subList = foodDao.getSomeFood(page,columnpage);
		} else {
			subList = foodDao.getSomeFoodById(page, Integer.parseInt(typeid),columnpage);
		}
		System.out.println(subList);
		return subList;
	}

	// 获得一个page类型的对象
	public Page getPage(String current_page, String typeid,String columnpage) {
		Page page = new Page();
		int count = 0;
		if ("0".equals(typeid)) {
			count = foodDao.getAllCount(columnpage);
		} else {
			count = foodDao.getCountById(Integer.parseInt(typeid),columnpage);
		}
		System.out.println("查询数量：" + count);
		page.setColumn_count(count);
		page.setColumn_page(Integer.parseInt(columnpage));
		if (current_page != null&&!"".equals(current_page)) {
			page.setCurrent_page(Integer.parseInt(current_page));
		}
		System.out.println("当前页" + page.getCurrent_page());
		return page;
	}

	//根据商品状态获得page
	public Page getPageByState(String current_page,String state) {
		Page page = new Page();
		int count = foodDao.getCountByState(state);
		System.out.println("查询数量：" + count);
		page.setColumn_count(count);
		page.setColumn_page(4);
		if (current_page != null&&!"".equals(current_page)) {
			page.setCurrent_page(Integer.parseInt(current_page));
		}
		System.out.println("当前页" + page.getCurrent_page());
		return page;
	}

	//根据商品状态和page获得部分商品
	public List<Food> getSomeFoodByState(Page page, String state) {
		List<Food> subList = foodDao.getSomeFoodByState(state,page);
		return subList;
	}
	
	// 根据id获得商品
	public Food getFoodById(String id) {
		// TODO Auto-generated method stub
		Food food = foodDao.getFoodById(Integer.parseInt(id));
		return food;
	}

	// 为购物车添加信息
	public CartBean addIntoCart(String foodid, CartBean cartbean, String text, String count) {
		Food food = foodDao.getFoodById(Integer.parseInt(foodid));
		System.out.println(foodid);
		// 获得该购物车的商品信息列表
		List<Food_Cart> foodcarts = foodDao.getFoodCarts(cartbean);
		for (Food_Cart f : foodcarts) {
			cartbean.add(f);
		}
		System.out.println("查数据库后的" + cartbean);
		if (cartbean.hasFood(food)) {
			// 修改数据库
			boolean result = foodDao.updateFoodCart(cartbean, food, text, Integer.parseInt(count));
			System.out.println("修改数据库后的" + cartbean);
			if (result == true) {
				return cartbean;
			}
			return null;
		} else {
			Food_Cart foodcart = foodDao.addFoodCart(cartbean, food, text, Integer.parseInt(count));
			if (foodcart != null) {
				cartbean.add(foodcart);
				System.out.println("添加成功后的" + cartbean);
				return cartbean;
			}
			return null;
		}

	}

	// 得到用户的购物车，没有就新建一个
	public CartBean getMyCart(User user) {
		CartBean cart = foodDao.getMyCart(user);
		System.out.println("有无购物车" + cart);
		if (cart == null) {
			CartBean c = foodDao.creatCart(user);
			return c;
		}
		return cart;
	}

	// 为查询出来的购物车添加商品信息
	public CartBean addFoodCartByPage(CartBean cartbean,Page page) {
		// 获得该购物车的商品信息列表
		List<Food_Cart> foodcarts = foodDao.getFoodCartsByPage(cartbean, page);
		for (Food_Cart f : foodcarts) {
			cartbean.add(f);
		}
		return cartbean;
	}

	// 为查询出来的购物车添加商品信息
		public CartBean addFoodCart(CartBean cartbean) {
			// 获得该购物车的商品信息列表
			List<Food_Cart> foodcarts = foodDao.getFoodCarts(cartbean);
			for (Food_Cart f : foodcarts) {
				cartbean.add(f);
			}
			return cartbean;
		}
	//清空购物车
	public boolean emptyCart(User user) {
		CartBean cart = foodDao.getMyCart(user);
		boolean result = foodDao.emptyCart(cart);
		return result;
	}

	//删除购物车中的商品
	public boolean deleteFoodCart(int foodid) {
		boolean result = foodDao.deleteFoodCart(foodid);
		return result;
	}

	//购物车中商品的数量减1
	public boolean cutFoodCount(int foodid) {
		int count = foodDao.getFoodCount(foodid);
		System.out.println("商品数量："+count);
		if(count<=1) {
			count=1;
		}else {
			count--;	
		}		
		System.out.println("更新后商品数量："+count);
		boolean result = foodDao.updateFoodCount(count,foodid);
		return result;
	}

	//购物车中商品的数量加1
	public boolean addFoodCount(int foodid) {
		int count = foodDao.getFoodCount(foodid);
		System.out.println("商品数量："+count);
		count++;		
		System.out.println("更新后商品数量："+count);
		boolean result = foodDao.updateFoodCount(count,foodid);
		return result;
	}

	//获取所有的商品类型
	public List<Type> getAllType() {
		List<Type> typeList = foodDao.getAllType();
		return typeList;
	}

	//根据id获取商品类型
	public Type getTypeById(String typeid) {
		Type type  = foodDao.getTypeById(Integer.parseInt(typeid));
		return type;
	}

	//接收图片并且插入数据
	public boolean addFood(Food food, String realPath, MultipartFile imagefile,Type type) throws IOException {
		// 保存图片
		if (!"".equals(imagefile.getOriginalFilename())) {
			String originalFilename = imagefile.getOriginalFilename();
			food.setImgurl("images" + "\\" + originalFilename);
			byte[] bytes = imagefile.getBytes();
			File file = new File(realPath + "\\" + originalFilename);
			FileOutputStream fo = new FileOutputStream(file);
			fo.write(bytes);
			fo.flush();
			fo.close();
		}
		food.setSale("1");
		boolean result = foodDao.insert(food,type);
		return result;
	}


	//后台修改商品
	public boolean updateFood(Food food, String realPath, MultipartFile imagefile, Type type) throws IOException {
		// 保存图片
		if (!"".equals(imagefile.getOriginalFilename())) {
			String originalFilename = imagefile.getOriginalFilename();
			food.setImgurl("images" + "\\" + originalFilename);
			byte[] bytes = imagefile.getBytes();
			File file = new File(realPath + "\\" + originalFilename);
			FileOutputStream fo = new FileOutputStream(file);
			fo.write(bytes);
			fo.flush();
			fo.close();
		}
		boolean result = foodDao.updateFood(food,type);
		return result;
	}

	//根据商品类型名获得商品类型
	public Type getTypeByName(String typename) {
		Type type = foodDao.getTypeByName(typename);
		return type;
	}

	//后台删除商品
	public boolean deleteFood(String id) {
		boolean result = foodDao.deleteFood(Integer.parseInt(id));
		return result;
	}

	//批量删除商品
	public boolean deleteFoods(String[] arr) {
		for(int i=0;i<arr.length;i++) {
			Integer it = Integer.valueOf(arr[i]);
			int iit = it.intValue();
			foodDao.deleteFood(iit);
		}
		return true;
	}

	//获得一个购物车page
	public Page getCartPage(String current_page, CartBean cartBean) {
		Page page = new Page();
		int count = foodDao.getCartFoodCount(cartBean);		
		System.out.println("查询数量：" + count);
		page.setColumn_count(count);
		page.setColumn_page(3);
		if (current_page != null) {
			page.setCurrent_page(Integer.parseInt(current_page));
		}
		System.out.println("当前页" + page.getCurrent_page());
		return page;
	}

	//批量删除购物车中商品信息
	public boolean deleteSomeFoodCart(String[] arr) {
		for(int i=0;i<arr.length;i++) {
			Integer it = Integer.valueOf(arr[i]);
			int iit = it.intValue();
			foodDao.deleteFoodCart(iit);
		}
		return true;
		
	}

	//根据商品名获得商品
	public Food getFoodByName(String name) {
		Food food = foodDao.getFoodByName(name);
		return food;
	}

	//新增商品类别
	public boolean addFoodType(String name) {
		return foodDao.insertFoodType(name);
	}

	//更新商品状态
	public boolean updateFoodState(String id, String state) {
		return foodDao.updateFoodState(Integer.parseInt(id),state);
	}


	//更新上下架
		public boolean updateFoodSale(String id, String sale) {
			return foodDao.updateFoodSale(Integer.parseInt(id),sale);
		}
		
	//根据商品id删除购物车信息
	public boolean deleteFoodCart(String id, User user) {
		CartBean cart  = foodDao.getMyCart(user);
		return 	foodDao.deleteFoodCart(Integer.parseInt(id),cart.getId());	
	}

	

}
