package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.*;

@WebServlet(value= {"/user/login", "/user/logout", "/user/mypage", "/user/update", "/user/update/pass","/user/upload","/user/join","/user/list","/user/list.json"})

public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO dao=new UserDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		HttpSession session=request.getSession();
		PrintWriter out = response.getWriter();
	
		
		switch(request.getServletPath()) {
		case "/user/list.json":
			Gson gson=new Gson();
			out.print(gson.toJson(dao.list()));//제이슨으로 변환
			break;
		case "/user/list":
			request.setAttribute("pageName", "/user/list.jsp");
			dis.forward(request, response);
			break;
		case"/user/join":
			 request.setAttribute("pageName", "/user/join.jsp");
		     dis.forward(request, response);
			break;
		case "/user/mypage" :
		     String uid = (String)session.getAttribute("uid");
		     request.setAttribute("user", dao.read(uid)); //유저로 불러오기ㅣ로 해씀,,!!
		     request.setAttribute("pageName", "/user/mypage.jsp");
		     dis.forward(request, response);
		     break;
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		case "/user/logout":
			session.invalidate();
			response.sendRedirect("/");
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		
		switch(request.getServletPath()) {
		//회원가입
				case"/user/join":
					UserVO user=new UserVO();
					user.setUid(request.getParameter("uid"));
					user.setUpass(request.getParameter("upass"));
					user.setUname(request.getParameter("uname"));
					System.out.println(user.toString());
					dao.insert(user);
					break;
				
				//비밀번호업데이트,,
				case"/user/update/pass":
					String uid1=request.getParameter("uid");
					String npass=request.getParameter("npass");//받는 이르믕ㄴ 변수임!
					dao.update(uid1,npass);//비밀번호변경,,보낼떈 이름꼭 맞춰서 보내줘야함
					break;
				
				//업데이트,,
				case "/user/update":
					UserVO vo=new UserVO();
					String uid=request.getParameter("uid");
					vo.setUid(uid);
					vo.setMemo(request.getParameter("memo"));
					vo.setUname(request.getParameter("uname"));
					System.out.println (vo.toString());
					dao.update(vo);//데이터베이스에 업데이트
					break;
					
		case "/user/login":
			 uid=request.getParameter("uid");
			String upass=request.getParameter("upass");
			 vo=dao.read(uid);
			int result=0; //아이디가 없는경우
			if(vo.getUid()!=null) {
				if(vo.getUpass().equals(upass)) {
					session.setAttribute("uid", uid);
					session.setAttribute("user", vo);

					result=1; //로그인 성공
				}else {
					result=2; //비밀번호 불일치
				}
			}
			out.print(result);
			break;
		}
	}
}








