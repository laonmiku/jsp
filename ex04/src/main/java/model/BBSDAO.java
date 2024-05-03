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
	
	//데이터갯수 구하기
	public int total ();//매개변수없응ㅁ특정검색어를 검색해서 그데이터구할거면 매개변수에()에 그거넣기

	//페이징,검색
	public ArrayList<BBSVO> list(int page, int size, String query);//구하는게 만으면 이거 VO로만들어서써도댐,,

	//검색된갯수
	public int total (String query); //검색해서 걸러진 애들 토탈




}
