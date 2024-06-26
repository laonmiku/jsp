package controller;

import java.io.*;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.group.Response;

import model.UserDAO;
import model.UserVO;

@WebServlet(value={"/user/login", "/user/mypage", "/user/join","/user/logout"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao= new UserDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/user/logout":
			HttpSession session =request.getSession();
			session.removeAttribute("uid");
			response.sendRedirect("/");
			break;
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		case "/user/mypage":
			break;
		case "/user/join":
			break;
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/user/login":
			String uid=request.getParameter("uid"); //가져오는거
			String upass=request.getParameter("upass");
			System.out.println("아이디:"+uid+"\n패스워드:"+upass);
			
			
			int result=0;
			UserVO vo=dao.read(uid);
			if(vo.getUid() != null) {
				if(upass.equals(vo.getUpass())) {//성공한경우
					HttpSession session =request.getSession();
					session.setAttribute("uid", uid);
					result=1;
				}else {
					result=2;
				}
			}
			
			out.print(result);
			break;
	
		}
	
	}
}

