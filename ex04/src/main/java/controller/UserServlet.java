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
						//슬래시빠트리면 500번
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");//한글꺠지면 명명 제일처음에해줘야함!!
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
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
		case"/user/logout":
			session.invalidate();
			response.sendRedirect("/");
			break;
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			//페이지네임없이 호출하면 오류남!페이지네임이 비어잇어서!!
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
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
		
		//사진업로드
		case "/user/upload":
			String path="/upload/photo/";//얘는 사진저자오디는경로패스임!
			MultipartRequest multi =new MultipartRequest(
				request,
				"c:"+ path,//그래서 씨에 업로드>포토 에 저장한ㄴ단거!
				1024*1024*10, //사진크기막아줌
				new DefaultFileRenamePolicy()//파일이름 알아서 중복안되게해줌
			);
			String fileName=multi.getFilesystemName("photo");
			String uid2=multi.getParameter("uid");
			System.out.println("파일이름:" + fileName+"\n아이디:"+uid2);
			String photo = path+ fileName;
			dao.uploadPhoto(uid2, photo);
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
			vo.setPhone(request.getParameter("phone"));
			vo.setUname(request.getParameter("uname"));
			vo.setAddress1(request.getParameter("address1"));
			vo.setAddress2(request.getParameter("address2"));
			
			System.out.println (vo.toString());
			dao.update(vo);//데이터베이스에 업데이트
			break;
		
		//로그인체크,,겨로가만리턴하니까 포스트
		case "/user/login":
			uid = request.getParameter("uid");
			String upass = request.getParameter("upass");
			System.out.println("id:"+uid+"\npw:"+upass);
			int result =0;
			vo=dao.read(uid);
			if(vo.getUid() !=null) {
				if(vo.getUpass().equals(upass)) {
					HttpSession session =request.getSession();
					session.setAttribute("user",vo); //vo를 user라는 이름으로 가져옴
					session.setAttribute("uid",uid);
					result=1; //둘다성공 1
				}else {
					result=2;//아이디일치,비번불일치 2
				}
			}
			out.print(result);
			break;
		}
	}

}
