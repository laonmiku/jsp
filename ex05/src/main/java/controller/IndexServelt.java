package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/")
public class IndexServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
   

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("pageName", "/about.jsp"); //페이지네임에다가 어바웃을넣고
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp"); //디스일때 홈으로가도록 설정
		dis.forward(request, response);//포워드로 부르기
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
