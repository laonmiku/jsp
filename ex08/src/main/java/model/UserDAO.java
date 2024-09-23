package model;
import java.sql.*;
import java.util.ArrayList;

public class UserDAO {
	Connection con=Database.CON;
	
	//사용자목록
	public ArrayList<UserVO> list() {
		ArrayList <UserVO> array=new ArrayList<UserVO>();
		try {
			String sql="select * from users order by jdate desc";
			PreparedStatement ps=con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				UserVO vo=new UserVO();
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setMemo(rs.getString("memo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("유저리스트:"+e.toString());
		}
		return array;
	}
	
	//회원가입,,uname,upass,uid하나씩대신에 그냥 통채로 vo를 가져오면 댐!!
	public void insert(UserVO vo) {
		try {
			String sql="insert into users(uid,upass,uname,jdate) values (?,?,?,now())";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getUpass());
			ps.setString(3, vo.getUname());
			ps.execute();
		} catch (Exception e) {
			System.out.println("회원가입:"+e.toString());
		}
	}
	
	//비밀번호수정,, 메소드이름이같아도 매개변수타입이 다르면 ㄱㅊ음(스트링두개.스트랭한개) =>오버로딩
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
			String sql="update users set udate=now(), uname=?,memo=? where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getMemo());
			ps.setString(3, vo.getUid());
			
			ps.execute();
		} catch (Exception e) {
			System.out.println("업데이트:"+e.toString());
		}
	}
	//사용자정보
	public UserVO read(String uid) {
		UserVO vo=new UserVO();
		try {
			String sql="select * from users where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setMemo(rs.getString("memo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				vo.setUdate(rs.getTimestamp("udate"));
			}
		}catch(Exception e) {
			System.out.println("사용자정보:" + e.toString());
		}
		return vo;
	}
}
