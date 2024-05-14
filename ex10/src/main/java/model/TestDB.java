package model;
import java.sql.*;

public class TestDB {

	public static void main(String[] args) {
		Connection con = Database.CON ;
		//UserDAO dao= new UserDAO();
		//UserVO vo= dao.read("red");
		//System.out.println(vo.toString());
		CartDAO dao= new CartDAO();
		dao.list("red");
		

	
	   
		
	}

}
