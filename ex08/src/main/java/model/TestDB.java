package model;
import java.sql.*;

public class TestDB {

	public static void main(String[] args) {
		//Connection con = Database.CON ;
		//ProDAOImpl dao= new ProDAOImpl();
		QueryVO vo = new QueryVO();
		//vo.setPage(1);
		//vo.setSize(2);
		//vo.setKey("dept");
		//vo.setWord("전자");
		//dao.list(vo);
		//System.out.println("검색수 : "+dao.total(vo));
		//System.out.println("다음 교수번호:"+dao.getCode());
		//dao.read("510");
		
		//StuDAOImpl dao = new StuDAOImpl();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("dept");
//		vo.setWord("건축");
		//dao.list(vo);
		//System.out.println("학생검색수 : "+dao.total(vo));
		//System.out.println("새코드 : "+dao.getCode());
		//dao.read("96414406");
		//boolean result=dao.delete("1");
		//System.out.println("결과는 ~~~~~~~~~~~~~~~~~"+result);
		
		//CouDAOImpl dao= new CouDAOImpl();
		//vo.setPage(1);
		//vo.setSize(2);
	//	vo.setKey("lname");
		//vo.setWord("리");
		//dao.list(vo);
		//System.out.println("검색수 : "+dao.total(vo)+"건");
		
		//dao.read("N224");
	   //   System.out.println("삭제결과 : " + dao.delete("N223"));
	    //  System.out.println("삭제결과 : " + dao.delete("E221"));
	      

		EnrollDAO dao= new EnrollDAO(); 
		//dao.list("95414058");
		dao.slist("C301");

	
	   
		
	}

}
