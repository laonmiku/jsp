package model;
import java.sql.*;
import java.util.ArrayList;


public class CartDAO {
	Connection con=Database.CON;
	
	//장바구니목록
	public ArrayList<CartVO> list(String uid){
		ArrayList<CartVO> array = new ArrayList<CartVO>();
		try {
			String sql=" select * from view_cart where uid=?  ";
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs =ps.executeQuery();
			while(rs.next()) {
				CartVO vo= new CartVO();
				vo.setUid(rs.getString("uid"));
				vo.setGid(rs.getString("gid"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				System.out.println(vo.toString());
				array.add(vo);
			}
		}catch (Exception e) {
			System.out.println("장바구니 목록 :"+e.toString());
		}
		return array;
	}
	
	//장바구니에 상품잇는지 유무체크
		public CartVO read (String uid, String gid) {
			CartVO vo= new CartVO();
			try {
				String sql=" select * from cart where uid=? ans gid=? ";
				PreparedStatement ps= con.prepareStatement(sql);
				ps.setString(1, uid);
				ps.setString(2, gid);
				ResultSet rs =ps.executeQuery();
				if(rs.next()) {
					vo.setUid(rs.getString("uid"));
					vo.setGid(rs.getString("gid"));
					vo.setQnt(rs.getInt("qnt"));
				}
			} catch (Exception e) {
				System.out.println("장바구니에 중복 오류 :"+e.toString());
			}
			return vo;
		}
	
	
	//장바구니에넣기
	public boolean insert(CartVO vo) {
		try {
			String sql="insert into cart(uid,gid,qnt) values(?,?,1) ";
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();
			return true;
		} catch (Exception e) {
			System.out.println("장바구니에 넣기 :"+e.toString());
			return false;
		}
		
	}
}
