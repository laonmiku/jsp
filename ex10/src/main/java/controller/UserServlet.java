package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.DrbgParameters.Reseed;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

@WebServlet(value={"/user/login","/user/"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO dao=new UserDAO();   
   

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out= response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out= response.getWriter();
		switch(request.getServletPath()) {
		case "/user/login":
			String uid= request.getParameter("uid");
			String upass= request.getParameter("upass");
			UserVO vo = dao.read(uid);
			int result=0; //아이디없음
			if(vo.getUid() != null) {
				if(vo.getUpass().equals(upass)) {
					result=1; //로그인성공
					
				}else {
					result=2; //비번틀림
				}
			}//아이디없음!엘스부분
			out.print(result);
			break ;
		}
	}

}
