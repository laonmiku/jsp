package model;

public class DBTest {

	public static void main(String[] args) {
		//BBSDAOImpl dao= new BBSDAOImpl();
		//dao.list();
		//dao.read(2);
		//System.out.println("총 게시글 수 : "+dao.total() +"개"); 
		//dao.list(3,5,"자바");
		//System.out.println("서치 => "+dao.total("죠"));
		CommentDAOImpl dao= new CommentDAOImpl();
		//dao.list(900, 1, 5);
		//System.out.println("936번 게시글의 댓글수 : "+dao.total(936)+"개");
		CommentVO vo=new CommentVO();
		//vo.setBid(935);
		//vo.setWriter("red");
		//vo.setContents("red왔다감");
		//dao.insert(vo);
	}

}
