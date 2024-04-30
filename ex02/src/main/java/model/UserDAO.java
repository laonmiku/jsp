package model;


import java.sql.*;

public class UserDAO {
	Connection con=Database.CON;
	//비밀번호수정,, 메소드이름이같아도 매개변수이름이 다르면 ㄱㅊ음 =>오버로딩
	public void update(String uid,String npass) {
		try {
			String sql="update users set upass=? where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, npass);
			ps.setString(2, uid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("비밀번호 업데이트:"+e.toString());
		}
	}
	
	//정보수정
	public void update(UserVO vo) {
		try {
			String sql="update users set udate=now(), uname=?,phone=?,address1=?,address2=? where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getPhone());
			ps.setString(3, vo.getAddress1());
			ps.setString(4, vo.getAddress2());
			ps.setString(5, vo.getUid());
			
			ps.execute();
		} catch (Exception e) {
			System.out.println("업데이트:"+e.toString());
		}
	}
	
	public UserVO read(String uid) {	
		UserVO vo = new UserVO();
		try {
			String sql="select * from users where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) { // 셀렉트결과값이 오른쪽으로나열되니까 그순서대로 넥스트한다는거임!
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				vo.setUdate(rs.getTimestamp("udate"));
			}
		} catch (Exception e) {
			System.out.println("read:"+e.toString());
		}
		return vo;
	}
	
}
