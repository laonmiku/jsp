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
		
		StuDAOImpl dao = new StuDAOImpl();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("dept");
//		vo.setWord("건축");
		//dao.list(vo);
		//System.out.println("학생검색수 : "+dao.total(vo));
		//System.out.println("새코드 : "+dao.getCode());
		dao.read("96414406");
	}

}
