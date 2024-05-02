package controllar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet/,,,,,,,,,,,,,,,,,,,,,,");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		//리퀘스트디스패쳐:페이지를 꺼내옴, 함수 지정
		request.setAttribute("pageName", "/about.jsp");
		//리퀘스트디스패쳐에 변수쓸때는 지정을 먼저하고 호출(포워드)해야함!
		dis.forward(request, response);
		//호출하기
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}
