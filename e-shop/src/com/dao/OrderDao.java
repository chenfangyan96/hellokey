package com.dao;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.common.Page;
import com.entity.Address;
import com.entity.CartBean;
import com.entity.Food;
import com.entity.Order;
import com.entity.OrderDetail;
import com.entity.User;

@Repository
public class OrderDao {
	@Autowired
	private SessionFactory sessionFactory;

	//插入订单和订单详情，级联修改相关属性
	public boolean insert(User u,Set<OrderDetail> oo, Order order) {
		Session session = sessionFactory.getCurrentSession();
		try {			
			for (OrderDetail o : oo) {
				o.setOrder(order);
				session.save(o);
			}
			session.save(order);
			User user = session.get(User.class, u.getId());
			order.setUser(user);
			user.getOrders().add(order);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	//根据订单查询该订单的订单详情
	public List<OrderDetail> getOrderDetails(int id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = " from OrderDetail o where o.order.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, id);
		List<OrderDetail> detailLsit = query.list();
		if(detailLsit.isEmpty()) {
			return null;
		}
		return detailLsit;
	}

	//根据用户的id获得该用户的订单列表
	public List<Order> getOrders(User u) {

		Session session  = sessionFactory.getCurrentSession();
		String hql = " from Order o where o.user.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, u.getId());
		List<Order> orders = query.list();
		if(orders.isEmpty()) {
			return null;
		}
		return orders;
	}

	//根据订单id获得订单
	public Order getOrder(int id) {
		Session session  = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, id);
		return order;
	}

	//根据用户获得当前地址
	public Address getCurrentAddress(User user) {
		Session session  = sessionFactory.getCurrentSession();
		User u = session.get(User.class, user.getId());
		Address address = u.getAddress();
		return address;
	}

	//根据状态获得订单记录条数
	public int getCount(String state) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "select count(o.id) from Order o where o.state=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, state);
		Long o = (Long) query.uniqueResult();
		int count = o.intValue();
		return count;
	}

	//获得所有订单总记录数
	public int getAllCount() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "select count(id) from Order";
		Query query = session.createQuery(hql);
		Long o = (Long) query.uniqueResult();
		int count = o.intValue();
		return count;
	}

	//根据page获取部分订单
	public List<Order> getSomeOrder(Page page) {	
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Order";
		Query query = session.createQuery(hql);
		int begin = 0;
		if (page.getPage_count() == 0 || page.getPage_count() == 1) {
			begin = 0;
		} else if (page.getCurrent_page() == page.getPage_count()) {
			begin = (page.getPage_count() - 1) * page.getColumn_page();
		} else {
			begin = (page.getCurrent_page() - 1) * page.getColumn_page();
		}
		query.setFirstResult(begin);
		query.setMaxResults(page.getColumn_page());
		List<Order> subList = query.list();
		return subList;
	}

	//根据page和state获取部分订单
	public List<Order> getSomeFoodByState(Page page, String state) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from Order o where o.state=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, state);
		int begin = 0;
		if (page.getPage_count() == 0 || page.getPage_count() == 1) {
			begin = 0;
		} else if (page.getCurrent_page() == page.getPage_count()) {
			begin = (page.getPage_count() - 1) * page.getColumn_page();
		} else {
			begin = (page.getCurrent_page() - 1) * page.getColumn_page();
		}
		query.setFirstResult(begin);
		if(page.getColumn_page()==0) {
			query.setMaxResults(0);
		}
		query.setMaxResults(page.getColumn_page());
		List<Order> subList = query.list();
		return subList;
	}

	//根据id修改订单状态
	public boolean updateOrderState(int id, String os) {
		Session session = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, id);
		order.setState(os);
		return true;
	}


	//根据订单id和商品获得订单详情
	public OrderDetail getOrderDetail(Food food, int id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from OrderDetail o where o.order.id=? and o.food.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, id);
		query.setParameter(1, food.getId());
		OrderDetail od = (OrderDetail) query.uniqueResult();
		return od;
	}

	//为订单增添订单详情
	public boolean addaddOrderDetail(Food food, int id, OrderDetail od) {
		Session session = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, id);
		od.setFood(food);
		od.setOrder(order);
		order.getOrderdetails().add(od);
		session.save(od);
		return true;
	}
	
	//删除根据订单id和订单详情id订单详情
	public boolean deleteOrderDetail(int id, int oid) {
		Session session = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, oid);
		OrderDetail od = session.get(OrderDetail.class, id);
		od.setFood(null);
		od.setOrder(null);
		order.getOrderdetails().remove(od);
		session.delete(od);
		session.flush();
		session.clear();
		return true;
	}

	//根据订单详情id获得订单详情
	public OrderDetail getOrderDetailById(int id) {
		Session session = sessionFactory.getCurrentSession();
		OrderDetail od = session.get(OrderDetail.class, id);
		return od;
	}

	//更新订单详情
	public boolean updateOrderDetail(int id, OrderDetail od) {
		Session session = sessionFactory.getCurrentSession();
		OrderDetail ood = session.get(OrderDetail.class, id);
		ood.setCount(od.getCount());
		ood.setText(od.getText());
		session.flush();
		return true;
	}

	//更新订单中的收货人，联系方式和地址
	public boolean updateOrder(Order o) {
		Session session = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, o.getId());
		System.out.println(o.getTelephone());
		order.setName(o.getName());
		order.setTelephone(o.getTelephone());
		order.setArea(o.getArea());
		order.setStreet(o.getStreet());
		o.setFulladdress(o.getFulladdress());
		session.flush();
		return true;
	}

	//删除订单
	public boolean deleteOrder(int id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = " delete from Order o where o.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, id);
		query.executeUpdate();
		return true;	
	}

	//根据订单id删除订单详情
	public boolean deleteOrderDetail(int id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = " delete from OrderDetail o where o.order.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, id);
		query.executeUpdate();
		return true;		
	}

	//根据商品id查询订单详情
	public List<OrderDetail> getOrderDetailsByFood(int id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from OrderDetail o where o.food.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, id);
		List<OrderDetail>oo = query.list();
		return oo;	
	}

	//根据订单id查询订单
	public Order getOrderById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Order order = session.get(Order.class, id);
		return order;	
	}
}
