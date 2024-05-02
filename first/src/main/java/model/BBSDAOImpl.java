package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;


public class BBSDAOImpl implements BBSDAO {
	Connection con=Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("날짜 : yyyy년 MM월 dd일  시간 : HH시 mm분 ss초");
	
	@Override
	public ArrayList<BBSVO> list() {
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		try {
			String sql="select * from view_bbs order by bid desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BBSVO vo = new BBSVO();
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				//vo.setBdate(rs.getString("bdate"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo);
				System.out.println(vo.toString());
			}
		} catch (Exception e) {
			System.out.println("게시판목록"+e.toString());
		}
		return array;
	}

	@Override
	public BBSVO read(int bid) {
		BBSVO vo = new BBSVO();
		try {
			String sql="select * from view_bbs where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,bid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				//vo.setBdate(rs.getString("bdate"));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				System.out.println(vo.toString());
			}
			
			
		} catch (Exception e) {
			System.out.println("게시글정보"+e.toString());
		}
		return vo;
	}

	@Override
	public void insert(BBSVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(BBSVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int bid) {
		// TODO Auto-generated method stub
		
	}

}
