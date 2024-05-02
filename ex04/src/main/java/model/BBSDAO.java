package model;
import java.util.*;

public interface BBSDAO {

	//목록(여러개 출력)
	public ArrayList<BBSVO> list();
	
	//목록(한개 출력)
	public BBSVO read (int bid);
	
	//입력
	public void insert (BBSVO vo); 
	
	//수정
	public void update (BBSVO vo);
	
	//삭제
	public void delete (int bid);
	
	//페이징 목록
	public ArrayList<BBSVO> list(int page, int size);
	
}
