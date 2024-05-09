package model;

import java.sql.*;
import java.util.*;

public class CouDAOImpl implements CouDAO {
	Connection con = Database.CON;
	@Override
	public ArrayList<CouVO> list(QueryVO vo) {
		ArrayList<CouVO> array= new ArrayList<CouVO> ();
		try {
			String sql="select * from view_cou";
			sql+=" where "+vo.getKey()+" like ?";
			sql+=" order by lcode desc ";
			sql+=" limit ?,? ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%"+vo.getWord()+"%" );
			ps.setInt(2, (vo.getPage()-1)*vo.getSize());
			ps.setInt(3, vo.getSize());
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				CouVO cou= new CouVO();
				cou.setLcode(rs.getString("lcode"));
				cou.setLname(rs.getString("lname"));
				cou.setHours(rs.getInt("hours"));
				cou.setRoom(rs.getString("room"));
				cou.setInstructor(rs.getString("instructor"));
				cou.setCapacity(rs.getInt("capacity"));
				cou.setPersons(rs.getInt("persons"));
				cou.setPname(rs.getString("pname"));
				System.out.println(cou.toString());
				array.add(cou);
			}
		} catch (Exception e) {
			System.out.println("강좌목록 : "+e.toString());
		}
		return array;
	}
	@Override
	public int total(QueryVO vo) {
		int result=0;
		try {
			String sql=" select count(*) from view_cou ";
			sql+=" where "+vo.getKey()+" like ? ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%"+vo.getWord()+"%" );
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				result=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			System.out.println("검색수 : "+e.toString());
		}
		return result;
	}
	@Override
	public String getCode() {
		String code="";
		try {
			String sql=" select concat('N',substring(max(lcode),2)+1) code from courses; ";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			if(rs.next()) {
				code=rs.getString("code");
			}
		} catch (Exception e) {
			System.out.println("새로운 강좌 코드 : "+e.toString());
		}
		return code;
		//써블릿에서 인서트에서 값가져갈떄 넣어줄거임
	}
	@Override
	public void insert(CouVO vo) {
		try {
			String sql="insert into courses(lcode,lname,hours,room,instructor,capacity,persons)  ";
			sql+=" values(?,?,?,?,?,?,0) ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getLcode());
		    ps.setString(2, vo.getLname());
		    ps.setInt(3, vo.getHours());
		    ps.setString(4, vo.getRoom());
		    ps.setString(5, vo.getInstructor());
		    ps.setInt(6, vo.getCapacity());
		    ps.execute();
		} catch (Exception e) {
			System.out.println("새로운강좌등록 : "+e.toString());
		}
		
	}
	@Override
	public CouVO read(String lcode) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void delete(CouVO vo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void update(CouVO vo) {
		// TODO Auto-generated method stub
		
	}
	
	

}
