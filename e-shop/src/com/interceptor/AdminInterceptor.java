package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.entity.User;

public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
	
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("admin");
		String action = request.getParameter("action");
		if(action!=null) {
			if (user == null) {
				String msg = "<script>alert(\"您还没登录，请先登录哦!\")</script>";
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/login.jsp").forward(request, response);
				return false;
			} else {
				return true;
			}
		}
		return true;
	}

}
