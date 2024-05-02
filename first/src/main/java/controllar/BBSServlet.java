package controllar;

import java.io.*;

import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet(value={"/bbs/list.json","/bbs/list","/bbs/insert","/bbs/read","/bbs/delete","/bbs/update"})
public class BBSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    BBSDAOImpl dao = new  BBSDAOImpl();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");//이건 Gson 쓰면 한글꺠지니까 잡아주는거 그래서 writer보다 위에,,
		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		
		case "/bbs/list.json":
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list()));
			break;
		
		case"/bbs/list":
			request.setAttribute("pageName", "/bbs/list.jsp");
			dis.forward(request, response);
			break;
			
		case"/bbs/read":
			String bid=request.getParameter("bid");
			System.out.println("bid =========> "+bid);
			BBSVO vo=dao.read(Integer.parseInt(bid));
			request.setAttribute("bbs",vo);
			request.setAttribute("pageName","/bbs/read.jsp");
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
