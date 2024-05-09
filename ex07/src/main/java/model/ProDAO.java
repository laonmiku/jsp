package model;
import java.util.*;

public interface ProDAO {

	//교수목록
	public ArrayList<ProVO> list( QueryVO vo );

	//검색수
	public int total(QueryVO vo);
	
	//교수등록
	public void insert(ProVO vo);
	
	//새로운교수번호
	public String getCode();
	
	//교수정보(1)
	public ProVO read ( String pcode);//primary key
	
	//교수정보 수정
	public void update(ProVO vo);
	
	//교수정보 삭제
	public int delete(String pcode);//primary key
									//근데 자식이있으면인되서 삭제되면 1 안되면(자식있으면) 0으로,,리턴!!
	
	
}
